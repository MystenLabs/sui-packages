module 0x107dcf9b0cfbb5d4c0534f3a335f7632f46004bd56b4cc9f1cc1a3556bde68cb::trade_in {
    struct Phone has store, key {
        id: 0x2::object::UID,
        model: u8,
    }

    struct Receipt {
        price: u64,
    }

    public fun trade_in(arg0: Receipt, arg1: Phone, arg2: 0x2::coin::Coin<0x2::sui::SUI>) {
        let Receipt { price: v0 } = arg0;
        let v1 = if (arg1.model == 1) {
            10000
        } else {
            20000
        };
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) == v0 - v1 / 2, 2);
        0x2::transfer::public_transfer<Phone>(arg1, @0x2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, @0x2);
    }

    public fun buy_phone(arg0: u8, arg1: &mut 0x2::tx_context::TxContext) : (Phone, Receipt) {
        assert!(arg0 == 1 || arg0 == 2, 1);
        let v0 = if (arg0 == 1) {
            10000
        } else {
            20000
        };
        let v1 = Phone{
            id    : 0x2::object::new(arg1),
            model : arg0,
        };
        let v2 = Receipt{price: v0};
        (v1, v2)
    }

    public fun pay_full(arg0: Receipt, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        let Receipt { price: v0 } = arg0;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) == v0, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, @0x2);
    }

    // decompiled from Move bytecode v6
}

