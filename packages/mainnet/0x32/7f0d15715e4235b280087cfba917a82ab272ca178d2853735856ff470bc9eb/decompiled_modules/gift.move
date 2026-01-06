module 0x327f0d15715e4235b280087cfba917a82ab272ca178d2853735856ff470bc9eb::gift {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct GiftConfig has key {
        id: 0x2::object::UID,
        treasury_address: address,
        fee_bps: u64,
    }

    struct GiftSent has copy, drop {
        gift_db_id: 0x1::string::String,
        sender: address,
        receiver: address,
        amount: u64,
        fee_deducted: u64,
    }

    struct FeeUpdated has copy, drop {
        old_fee_bps: u64,
        new_fee_bps: u64,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        let v2 = GiftConfig{
            id               : 0x2::object::new(arg0),
            treasury_address : v0,
            fee_bps          : 100,
        };
        0x2::transfer::transfer<AdminCap>(v1, v0);
        0x2::transfer::share_object<GiftConfig>(v2);
    }

    public fun update_fee(arg0: &AdminCap, arg1: &mut GiftConfig, arg2: u64) {
        assert!(arg2 <= 1000, 1);
        arg1.fee_bps = arg2;
        let v0 = FeeUpdated{
            old_fee_bps : arg1.fee_bps,
            new_fee_bps : arg2,
        };
        0x2::event::emit<FeeUpdated>(v0);
    }

    public fun wrap_gift(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: address, arg3: 0x1::string::String, arg4: &GiftConfig, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 3);
        let v1 = v0 * arg4.fee_bps / 10000;
        assert!(0x2::coin::value<0x2::sui::SUI>(arg1) >= v1, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg1, v1, arg5), arg4.treasury_address);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, arg2);
        let v2 = GiftSent{
            gift_db_id   : arg3,
            sender       : 0x2::tx_context::sender(arg5),
            receiver     : arg2,
            amount       : v0,
            fee_deducted : v1,
        };
        0x2::event::emit<GiftSent>(v2);
    }

    // decompiled from Move bytecode v6
}

