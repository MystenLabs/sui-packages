module 0xccc64460ea3c00eac5baf562d9de43ce5123113320e5972a8e91a0fa1490ff99::pawtato_tool_upgrades {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public fun consume_upgrade_quality<T0>(arg0: &AdminCap, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: 0x2::coin::Coin<T0>, arg5: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg6: &mut 0x67b49498b9e3d942c9ba3c5442fc85aa2011abcdc1a2edf73d83cb4af46f46e0::pawtato_tool_upgrades::ToolUpgrades, arg7: &0x2::random::Random, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        0x67b49498b9e3d942c9ba3c5442fc85aa2011abcdc1a2edf73d83cb4af46f46e0::pawtato_tool_upgrades::consume_upgrade_quality<T0>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg9);
        assert!(get_quality(immutable_borrow_example<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>(arg1, arg2, arg3)) != arg8, 777888999);
    }

    public fun upgrade_tool_basic(arg0: &AdminCap, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: 0x2::coin::Coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>, arg5: vector<0x2::object::ID>, arg6: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg7: &mut 0x67b49498b9e3d942c9ba3c5442fc85aa2011abcdc1a2edf73d83cb4af46f46e0::pawtato_tool_upgrades::ToolUpgrades, arg8: &mut 0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg9: &0x2::random::Random, arg10: 0x1::string::String, arg11: &mut 0x2::tx_context::TxContext) {
        0x67b49498b9e3d942c9ba3c5442fc85aa2011abcdc1a2edf73d83cb4af46f46e0::pawtato_tool_upgrades::upgrade_tool_basic(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg11);
        assert!(*gettype(arg0, immutable_borrow_example<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>(arg1, arg2, arg3)) == arg10, 888999);
    }

    public fun get_quality(arg0: &0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL) : u64 {
        let v0 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_quality_value(arg0);
        if (0x1::option::is_some<u64>(&v0)) {
            *0x1::option::borrow<u64>(&v0)
        } else {
            0
        }
    }

    public fun gettype(arg0: &AdminCap, arg1: &0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL) : &0x1::string::String {
        0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_tier(arg1)
    }

    public fun immutable_borrow_example<T0: store + key>(arg0: &0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID) : &T0 {
        0x2::kiosk::borrow<T0>(arg0, arg1, arg2)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun newapc(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg2)};
        0x2::transfer::transfer<AdminCap>(v0, arg1);
    }

    public fun testtt(arg0: &AdminCap, arg1: &0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID) : &0x1::string::String {
        gettype(arg0, immutable_borrow_example<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>(arg1, arg2, arg3))
    }

    public fun testtt2(arg0: &AdminCap, arg1: &0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x1::string::String, arg4: 0x2::object::ID) : (&0x1::string::String, bool) {
        let v0 = gettype(arg0, immutable_borrow_example<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>(arg1, arg2, arg4));
        (v0, *v0 == arg3)
    }

    public fun upgrade_staked_tool_with_sui(arg0: &AdminCap, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: 0x2::coin::Coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: vector<0x2::object::ID>, arg7: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg8: &mut 0x67b49498b9e3d942c9ba3c5442fc85aa2011abcdc1a2edf73d83cb4af46f46e0::pawtato_tool_upgrades::ToolUpgrades, arg9: &mut 0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg10: &0x2::random::Random, arg11: 0x1::string::String, arg12: &mut 0x2::tx_context::TxContext) {
        0x67b49498b9e3d942c9ba3c5442fc85aa2011abcdc1a2edf73d83cb4af46f46e0::pawtato_tool_upgrades::upgrade_tool_with_sui(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg12);
        let v0 = immutable_borrow_example<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>(arg1, arg2, arg3);
        assert!(*gettype(arg0, v0) == arg11, 888999);
        assert!(get_quality(v0) > 70, 999999);
    }

    // decompiled from Move bytecode v6
}

