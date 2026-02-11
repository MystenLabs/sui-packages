module 0xce42a683a94fc4fd1f0be5cdd2459acd82535c7800b4847a9cc4965cfcb5182d::handles {
    struct HandleRegistry has key {
        id: 0x2::object::UID,
        handles: 0x2::table::Table<0x1::string::String, address>,
    }

    struct HandleClaimed has copy, drop {
        owner: address,
        handle: 0x1::string::String,
        paid: u64,
    }

    entry fun claim_handle(arg0: &0xce42a683a94fc4fd1f0be5cdd2459acd82535c7800b4847a9cc4965cfcb5182d::platform::PlatformConfig, arg1: &mut 0xce42a683a94fc4fd1f0be5cdd2459acd82535c7800b4847a9cc4965cfcb5182d::platform::PlatformTreasury, arg2: &mut HandleRegistry, arg3: vector<u8>, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x1::string::utf8(arg3);
        assert!(!0x2::table::contains<0x1::string::String, address>(&arg2.handles, v1), 1);
        let v2 = 0xce42a683a94fc4fd1f0be5cdd2459acd82535c7800b4847a9cc4965cfcb5182d::platform::handle_claim_fee_micro(arg0);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg4) >= v2, 2);
        if (0x2::coin::value<0x2::sui::SUI>(&arg4) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg4, v0);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg4);
        };
        0xce42a683a94fc4fd1f0be5cdd2459acd82535c7800b4847a9cc4965cfcb5182d::platform::deposit_usde(arg1, 0x2::coin::split<0x2::sui::SUI>(&mut arg4, v2, arg5));
        0x2::table::add<0x1::string::String, address>(&mut arg2.handles, v1, v0);
        let v3 = HandleClaimed{
            owner  : v0,
            handle : v1,
            paid   : v2,
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

    // decompiled from Move bytecode v6
}

