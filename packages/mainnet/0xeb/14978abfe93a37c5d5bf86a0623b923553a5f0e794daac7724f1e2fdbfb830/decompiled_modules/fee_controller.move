module 0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::fee_controller {
    struct MinFeeControllerSet has copy, drop {
        min_fee_controller: address,
    }

    struct MinFeeSet has copy, drop {
        token_address: address,
        min_fee: u256,
    }

    struct FeeRecipientSet has copy, drop {
        fee_recipient: address,
    }

    fun assert_is_min_fee_controller(arg0: &0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::state::State, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == 0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::roles::min_fee_controller(0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::state::roles(arg0)), 0);
    }

    public(friend) fun calculate_min_fee_amount(arg0: &0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::state::State, arg1: address, arg2: u256) : u256 {
        let v0 = 0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::state::min_fee(arg0, arg1);
        if (v0 == 0) {
            return 0
        };
        assert!(arg2 > 1, 6);
        let v1 = arg2 * v0 / 10000000;
        if (v1 == 0) {
            return 1
        };
        v1
    }

    entry fun set_fee_recipient(arg0: &mut 0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::state::State, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::version_control::assert_object_version_is_compatible_with_package(0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::state::compatible_versions(arg0));
        0xe0917b74a5912e4ad186ac634e29c922ab83903f71af7500969f9411706f9b9a::two_step_role::assert_sender_is_active_role<0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::roles::OwnerRole>(0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::roles::owner_role(0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::state::roles(arg0)), arg2);
        assert!(arg1 != @0x0, 3);
        assert!(arg1 != 0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::state::fee_recipient(arg0), 4);
        0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::state::set_fee_recipient(arg0, arg1);
        let v0 = FeeRecipientSet{fee_recipient: arg1};
        0x2::event::emit<FeeRecipientSet>(v0);
    }

    entry fun set_min_fee(arg0: &mut 0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::state::State, arg1: address, arg2: u256, arg3: &0x2::tx_context::TxContext) {
        0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::version_control::assert_object_version_is_compatible_with_package(0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::state::compatible_versions(arg0));
        assert_is_min_fee_controller(arg0, arg3);
        assert!(arg2 < 10000000, 5);
        0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::state::set_min_fee(arg0, arg1, arg2);
        let v0 = MinFeeSet{
            token_address : arg1,
            min_fee       : arg2,
        };
        0x2::event::emit<MinFeeSet>(v0);
    }

    entry fun set_min_fee_controller(arg0: &mut 0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::state::State, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::version_control::assert_object_version_is_compatible_with_package(0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::state::compatible_versions(arg0));
        0xe0917b74a5912e4ad186ac634e29c922ab83903f71af7500969f9411706f9b9a::two_step_role::assert_sender_is_active_role<0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::roles::OwnerRole>(0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::roles::owner_role(0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::state::roles(arg0)), arg2);
        assert!(arg1 != @0x0, 1);
        assert!(arg1 != 0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::roles::min_fee_controller(0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::state::roles(arg0)), 2);
        0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::roles::update_min_fee_controller(0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::state::roles_mut(arg0), arg1);
        let v0 = MinFeeControllerSet{min_fee_controller: arg1};
        0x2::event::emit<MinFeeControllerSet>(v0);
    }

    // decompiled from Move bytecode v7
}

