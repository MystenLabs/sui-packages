module 0x39e56fc1b75b59bfa8e9043a26d77e158633a0aa2e8297d526721152ea03b1f1::handles {
    struct HandleRegistry has key {
        id: 0x2::object::UID,
        handles: 0x2::table::Table<0x1::string::String, address>,
    }

    struct HandleClaimed has copy, drop {
        handle: 0x1::string::String,
        owner: address,
    }

    entry fun claim_handle(arg0: &0x39e56fc1b75b59bfa8e9043a26d77e158633a0aa2e8297d526721152ea03b1f1::platform::PlatformConfig, arg1: &mut 0x39e56fc1b75b59bfa8e9043a26d77e158633a0aa2e8297d526721152ea03b1f1::platform::PlatformTreasury, arg2: &mut HandleRegistry, arg3: vector<u8>, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!0x39e56fc1b75b59bfa8e9043a26d77e158633a0aa2e8297d526721152ea03b1f1::platform::is_paused(arg0), 1);
        let v0 = 0x1::string::utf8(arg3);
        assert!(!0x2::table::contains<0x1::string::String, address>(&arg2.handles, v0), 2);
        let v1 = 0x39e56fc1b75b59bfa8e9043a26d77e158633a0aa2e8297d526721152ea03b1f1::platform::handle_claim_fee_micro(arg0);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg4) >= v1, 3);
        if (0x2::coin::value<0x2::sui::SUI>(&arg4) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg4, 0x2::tx_context::sender(arg5));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg4);
        };
        0x39e56fc1b75b59bfa8e9043a26d77e158633a0aa2e8297d526721152ea03b1f1::platform::deposit_sui(arg1, 0x2::coin::split<0x2::sui::SUI>(&mut arg4, v1, arg5));
        let v2 = 0x2::tx_context::sender(arg5);
        0x2::table::add<0x1::string::String, address>(&mut arg2.handles, v0, v2);
        let v3 = HandleClaimed{
            handle : v0,
            owner  : v2,
        };
        0x2::event::emit<HandleClaimed>(v3);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = HandleRegistry{
            id      : 0x2::object::new(arg0),
            handles : 0x2::table::new<0x1::string::String, address>(arg0),
        };
        0x2::transfer::share_object<HandleRegistry>(v0);
    }

    public fun is_available(arg0: &HandleRegistry, arg1: vector<u8>) : bool {
        !0x2::table::contains<0x1::string::String, address>(&arg0.handles, 0x1::string::utf8(arg1))
    }

    // decompiled from Move bytecode v6
}

