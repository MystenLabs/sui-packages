module 0xf137a9af0d71238fc7db25daef2fedaef2c4793842066ad2389b9454f8bccb60::admin {
    struct ADMIN has drop {
        dummy_field: bool,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: ADMIN, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<ADMIN>(arg0, arg1);
        let v0 = 0;
        while (v0 < 10) {
            let v1 = AdminCap{id: 0x2::object::new(arg1)};
            0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg1));
            v0 = v0 + 1;
        };
    }

    public fun mint_admin(arg0: &0x2::package::Publisher, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg2)};
        0x2::transfer::transfer<AdminCap>(v0, arg1);
    }

    // decompiled from Move bytecode v6
}

