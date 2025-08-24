module 0x3d8deafe1a7ddf0a8b8ea8711d1d74f83d8fab26b9413b1149942025366eb69a::leverage_admin {
    struct LEVERAGE_ADMIN has drop {
        dummy_field: bool,
    }

    struct LeverageAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct LeverageApp has store, key {
        id: 0x2::object::UID,
        markets: 0x2::vec_set::VecSet<0x2::object::ID>,
    }

    fun init(arg0: LEVERAGE_ADMIN, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<LEVERAGE_ADMIN>(arg0, arg1);
        let v0 = LeverageAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<LeverageAdminCap>(v0, 0x2::tx_context::sender(arg1));
        let v1 = LeverageApp{
            id      : 0x2::object::new(arg1),
            markets : 0x2::vec_set::empty<0x2::object::ID>(),
        };
        0x2::transfer::public_share_object<LeverageApp>(v1);
    }

    public fun onboard_market(arg0: &LeverageAdminCap, arg1: &mut LeverageApp, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::vec_set::contains<0x2::object::ID>(&arg1.markets, &arg2), 13906834324667236351);
        0x2::vec_set::insert<0x2::object::ID>(&mut arg1.markets, arg2);
        0x2::transfer::public_share_object<0x3d8deafe1a7ddf0a8b8ea8711d1d74f83d8fab26b9413b1149942025366eb69a::leverage_market::LeverageMarket>(0x3d8deafe1a7ddf0a8b8ea8711d1d74f83d8fab26b9413b1149942025366eb69a::leverage_market::new_market(arg2, arg3));
    }

    // decompiled from Move bytecode v6
}

