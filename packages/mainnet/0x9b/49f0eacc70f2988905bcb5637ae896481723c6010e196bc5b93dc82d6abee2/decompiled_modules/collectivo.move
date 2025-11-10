module 0x9b49f0eacc70f2988905bcb5637ae896481723c6010e196bc5b93dc82d6abee2::collectivo {
    struct COLLECTIVO has drop {
        dummy_field: bool,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public fun deposit_fee(arg0: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, @0x439ae2c715ffbe9263f1414944da00209f51ec27686a11102792a9fe8546eeb8);
    }

    fun init(arg0: COLLECTIVO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

