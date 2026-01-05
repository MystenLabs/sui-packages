module 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::linked_list {
    struct LinkedList<T0: copy + drop + store, phantom T1: store> has drop, store {
        id: 0x2::object::ID,
        first: 0x1::option::Option<T0>,
        last: 0x1::option::Option<T0>,
        length: u64,
    }

    struct Node<T0: copy + drop + store, T1: store> has copy, drop, store {
        value: T1,
        prev: 0x1::option::Option<T0>,
        next: 0x1::option::Option<T0>,
        exists: bool,
    }

    public fun length<T0: copy + drop + store, T1: store>(arg0: &LinkedList<T0, T1>) : u64 {
        abort 0
    }

    public fun borrow<T0: copy + drop + store, T1: store>(arg0: &0x2::object::UID, arg1: &LinkedList<T0, T1>, arg2: T0) : &T1 {
        abort 0
    }

    public fun push_back<T0: copy + drop + store, T1: drop + store>(arg0: &mut 0x2::object::UID, arg1: &mut LinkedList<T0, T1>, arg2: T0, arg3: T1) {
        abort 0
    }

    public fun borrow_mut<T0: copy + drop + store, T1: store>(arg0: &mut 0x2::object::UID, arg1: &LinkedList<T0, T1>, arg2: T0) : &mut T1 {
        abort 0
    }

    public fun pop_back<T0: copy + drop + store, T1: copy + store>(arg0: &mut 0x2::object::UID, arg1: &mut LinkedList<T0, T1>) : (T0, T1) {
        abort 0
    }

    public fun chain<T0: copy + drop + store, T1: store>(arg0: &mut LinkedList<T0, T1>, arg1: &mut LinkedList<T0, T1>) {
        abort 0
    }

    public fun contains<T0: copy + drop + store, T1: store>(arg0: &0x2::object::UID, arg1: &LinkedList<T0, T1>, arg2: T0) : bool {
        abort 0
    }

    public fun delete<T0: copy + drop + store, T1: copy + store>(arg0: &mut 0x2::object::UID, arg1: &mut LinkedList<T0, T1>, arg2: T0) : T1 {
        abort 0
    }

    public fun first<T0: copy + drop + store, T1: store>(arg0: &LinkedList<T0, T1>) : 0x1::option::Option<T0> {
        abort 0
    }

    public fun is_empty<T0: copy + drop + store, T1: store>(arg0: &LinkedList<T0, T1>) : bool {
        abort 0
    }

    public fun last<T0: copy + drop + store, T1: store>(arg0: &LinkedList<T0, T1>) : 0x1::option::Option<T0> {
        abort 0
    }

    public fun new<T0: copy + drop + store, T1: store>(arg0: 0x2::object::ID) : LinkedList<T0, T1> {
        abort 0
    }

    public fun new_node<T0: copy + drop + store, T1: store>(arg0: T1, arg1: 0x1::option::Option<T0>, arg2: 0x1::option::Option<T0>) : Node<T0, T1> {
        abort 0
    }

    public fun next<T0: copy + drop + store, T1: store>(arg0: &0x2::object::UID, arg1: &LinkedList<T0, T1>, arg2: T0) : 0x1::option::Option<T0> {
        abort 0
    }

    public fun node_exists<T0: copy + drop + store, T1: store>(arg0: &Node<T0, T1>) : bool {
        abort 0
    }

    public fun node_value<T0: copy + drop + store, T1: store>(arg0: &Node<T0, T1>) : &T1 {
        abort 0
    }

    public fun pop_front<T0: copy + drop + store, T1: copy + store>(arg0: &mut 0x2::object::UID, arg1: &mut LinkedList<T0, T1>) : (T0, T1) {
        abort 0
    }

    public fun pop_node<T0: copy + drop + store, T1: copy + store>(arg0: &mut 0x2::object::UID, arg1: T0) : T1 {
        abort 0
    }

    public fun prepare_node<T0: copy + drop + store, T1: drop + store>(arg0: &mut 0x2::object::UID, arg1: T0, arg2: T1) {
        abort 0
    }

    public fun prev<T0: copy + drop + store, T1: store>(arg0: &0x2::object::UID, arg1: &LinkedList<T0, T1>, arg2: T0) : 0x1::option::Option<T0> {
        abort 0
    }

    public fun push_front<T0: copy + drop + store, T1: drop + store>(arg0: &mut 0x2::object::UID, arg1: &mut LinkedList<T0, T1>, arg2: T0, arg3: T1) {
        abort 0
    }

    public fun push_node<T0: copy + drop + store, T1: drop + store>(arg0: &mut 0x2::object::UID, arg1: T0, arg2: Node<T0, T1>) {
        abort 0
    }

    public fun put_back<T0: copy + drop + store, T1: store>(arg0: &mut 0x2::object::UID, arg1: &mut LinkedList<T0, T1>, arg2: T0, arg3: T1) : 0x1::option::Option<T1> {
        abort 0
    }

    public fun put_front<T0: copy + drop + store, T1: store>(arg0: &mut 0x2::object::UID, arg1: &mut LinkedList<T0, T1>, arg2: T0, arg3: T1) : 0x1::option::Option<T1> {
        abort 0
    }

    public fun put_node<T0: copy + drop + store, T1: store>(arg0: &mut 0x2::object::UID, arg1: T0, arg2: Node<T0, T1>) : 0x1::option::Option<T1> {
        abort 0
    }

    public fun remove<T0: copy + drop + store, T1: copy + store>(arg0: &mut 0x2::object::UID, arg1: &mut LinkedList<T0, T1>, arg2: T0) : T1 {
        abort 0
    }

    public fun remove_node<T0: copy + drop + store, T1: drop + store>(arg0: &mut 0x2::object::UID, arg1: T0) {
        abort 0
    }

    public fun take_back<T0: copy + drop + store, T1: store>(arg0: &mut 0x2::object::UID, arg1: &mut LinkedList<T0, T1>) : (T0, T1) {
        abort 0
    }

    public fun take_front<T0: copy + drop + store, T1: store>(arg0: &mut 0x2::object::UID, arg1: &mut LinkedList<T0, T1>) : (T0, T1) {
        abort 0
    }

    public fun take_node<T0: copy + drop + store, T1: store>(arg0: &mut 0x2::object::UID, arg1: T0) : T1 {
        abort 0
    }

    // decompiled from Move bytecode v6
}

