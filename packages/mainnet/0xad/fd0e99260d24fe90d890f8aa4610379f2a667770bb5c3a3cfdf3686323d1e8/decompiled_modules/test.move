module 0x5803e7b2692ff940354e0a81ef7b2085deaf64d8dae7dde237d32af68e29ea44::test {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct NonceState has store, key {
        id: 0x2::object::UID,
        nonce: u64,
    }

    struct TransferAuthority has store, key {
        id: 0x2::object::UID,
    }

    fun allowed_steps() : vector<u8> {
        x"010203040564"
    }

    public fun increase_nonce(arg0: &AdminCap, arg1: &mut NonceState, arg2: vector<u8>) {
        assert!(arg2 == allowed_steps(), 0);
        arg1.nonce = arg1.nonce + 1;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, v0);
        let v2 = NonceState{
            id    : 0x2::object::new(arg0),
            nonce : 0,
        };
        0x2::transfer::transfer<NonceState>(v2, v0);
        let v3 = TransferAuthority{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<TransferAuthority>(v3, v0);
    }

    public fun nonce(arg0: &NonceState) : u64 {
        arg0.nonce
    }

    public fun version() : u64 {
        2
    }

    // decompiled from Move bytecode v7
}

