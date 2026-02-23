module 0x6da9b9bfd00a3dc5c5b702692900eb12808b9a8dc393c16de288e499f05bb73::generics {
    struct Box<T0: store> has store, key {
        id: 0x2::object::UID,
        value: T0,
    }

    struct Token<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: u64,
    }

    struct Pair<T0: drop + store, T1: drop + store> has drop, store {
        first: T0,
        second: T1,
    }

    public fun balance<T0>(arg0: &Token<T0>) : u64 {
        arg0.balance
    }

    public fun create_and_transfer_box<T0: store>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Box<T0>{
            id    : 0x2::object::new(arg1),
            value : arg0,
        };
        0x2::transfer::transfer<Box<T0>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun create_and_transfer_sui_token(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Token<0x2::sui::SUI>{
            id      : 0x2::object::new(arg0),
            balance : 0,
        };
        0x2::transfer::transfer<Token<0x2::sui::SUI>>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun create_and_transfer_token<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Token<T0>{
            id      : 0x2::object::new(arg0),
            balance : 0,
        };
        0x2::transfer::transfer<Token<T0>>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun create_box<T0: store>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : Box<T0> {
        Box<T0>{
            id    : 0x2::object::new(arg1),
            value : arg0,
        }
    }

    public fun create_pair<T0: drop + store, T1: drop + store>(arg0: T0, arg1: T1) : Pair<T0, T1> {
        Pair<T0, T1>{
            first  : arg0,
            second : arg1,
        }
    }

    public fun create_sui_token(arg0: &mut 0x2::tx_context::TxContext) : Token<0x2::sui::SUI> {
        Token<0x2::sui::SUI>{
            id      : 0x2::object::new(arg0),
            balance : 0,
        }
    }

    public fun deposit<T0>(arg0: &mut Token<T0>, arg1: Token<T0>) {
        let Token {
            id      : v0,
            balance : v1,
        } = arg1;
        0x2::object::delete(v0);
        arg0.balance = arg0.balance + v1;
    }

    public fun unbox<T0: store>(arg0: Box<T0>) : T0 {
        let Box {
            id    : v0,
            value : v1,
        } = arg0;
        0x2::object::delete(v0);
        v1
    }

    // decompiled from Move bytecode v6
}

