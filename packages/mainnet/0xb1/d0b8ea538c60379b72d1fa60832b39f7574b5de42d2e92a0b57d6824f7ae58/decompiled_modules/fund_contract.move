module 0xb1d0b8ea538c60379b72d1fa60832b39f7574b5de42d2e92a0b57d6824f7ae58::fund_contract {
    struct Fund has key {
        id: 0x2::object::UID,
        target: u64,
        raised: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct Receipt has key {
        id: 0x2::object::UID,
        amount_donated: u64,
    }

    struct FundOwnerCap has key {
        id: 0x2::object::UID,
        fund_id: 0x2::object::ID,
    }

    struct TargetReached has copy, drop {
        raised_amount_sui: u128,
    }

    public entry fun create_fund(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg1);
        let v1 = Fund{
            id     : v0,
            target : arg0,
            raised : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        let v2 = FundOwnerCap{
            id      : 0x2::object::new(arg1),
            fund_id : 0x2::object::uid_to_inner(&v0),
        };
        0x2::transfer::transfer<FundOwnerCap>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<Fund>(v1);
    }

    public entry fun donate(arg0: &mut Fund, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.raised, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v0 = (0x2::balance::value<0x2::sui::SUI>(&arg0.raised) as u128);
        if (v0 * 1 >= (arg0.target as u128) * 1000000000) {
            let v1 = TargetReached{raised_amount_sui: v0};
            0x2::event::emit<TargetReached>(v1);
        };
        let v2 = Receipt{
            id             : 0x2::object::new(arg2),
            amount_donated : 0x2::coin::value<0x2::sui::SUI>(&arg1),
        };
        0x2::transfer::transfer<Receipt>(v2, 0x2::tx_context::sender(arg2));
    }

    public entry fun withdraw_funds(arg0: &FundOwnerCap, arg1: &mut Fund, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(&arg0.fund_id == 0x2::object::uid_as_inner(&arg1.id), 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.raised, 0x2::balance::value<0x2::sui::SUI>(&arg1.raised), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

