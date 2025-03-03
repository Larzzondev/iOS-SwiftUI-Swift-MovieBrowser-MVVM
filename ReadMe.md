//
//  ReadMe.md
//  Fast31
//
//  Created by Rockwell on 2025-03-02.
//


# Fast31 - SwiftUI Movie Browser App (MVVM)

## Architecture

**Fast31** follows the **MVVM (Model-View-ViewModel)** architecture, which ensures separation of concerns and a clean structure:

- **Model**: Defines the data structures and represents the business logic.
- **View**: SwiftUI views that render the UI and handle user interactions.
- **ViewModel**: Manages business logic, data transformation, and communication between the Model and the View.

This architecture promotes **scalability**, **testability**, and **maintainability**, making it easier to manage UI state and network operations.

### **Mermaid Diagram**
Below is a visual representation of the **MVVM** architecture used in this project.

```mermaid
graph TD;
    A[Fast31App] -->|Initializes| B[View]
    B -->|Displays UI| C[ViewModel]
    C -->|Requests Data| D[Model]
    C -->|Fetches Data| E[API Service]
    D -->|Stores Movie Data| F[Movie Model]
    E -->|Calls API| G[Network Layer]
