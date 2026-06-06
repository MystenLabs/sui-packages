module 0xe4795695a8baf9508250d2a964842ad19b7afccb3bc8bfabc30c8fe82b38eb10::actions {
    struct ActionReceipt {
        vault_id: 0x2::object::ID,
        borrowed_amount: u64,
        is_sui: bool,
    }

    public fun execute_swap_mock_dex_to_sui(arg0: &mut 0xe4795695a8baf9508250d2a964842ad19b7afccb3bc8bfabc30c8fe82b38eb10::vault::Vault, arg1: &mut 0xe4795695a8baf9508250d2a964842ad19b7afccb3bc8bfabc30c8fe82b38eb10::agent_cap::AgentCap, arg2: &mut 0xe4795695a8baf9508250d2a964842ad19b7afccb3bc8bfabc30c8fe82b38eb10::mock_dex::Pool, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xe4795695a8baf9508250d2a964842ad19b7afccb3bc8bfabc30c8fe82b38eb10::mock_dex::swap_mock_dex_to_sui(arg2, 0xe4795695a8baf9508250d2a964842ad19b7afccb3bc8bfabc30c8fe82b38eb10::vault::borrow_MOCK_DEX(arg0, arg1, arg3, arg5), arg5);
        assert!(0x2::coin::value<0x2::sui::SUI>(&v0) >= arg4, 3);
        0xe4795695a8baf9508250d2a964842ad19b7afccb3bc8bfabc30c8fe82b38eb10::vault::return_sui(arg0, v0);
    }

    public fun execute_swap_sui_to_MOCK_DEX(arg0: &mut 0xe4795695a8baf9508250d2a964842ad19b7afccb3bc8bfabc30c8fe82b38eb10::vault::Vault, arg1: &mut 0xe4795695a8baf9508250d2a964842ad19b7afccb3bc8bfabc30c8fe82b38eb10::agent_cap::AgentCap, arg2: &mut 0xe4795695a8baf9508250d2a964842ad19b7afccb3bc8bfabc30c8fe82b38eb10::mock_dex::Pool, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xe4795695a8baf9508250d2a964842ad19b7afccb3bc8bfabc30c8fe82b38eb10::mock_dex::swap_sui_to_MOCK_DEX(arg2, 0xe4795695a8baf9508250d2a964842ad19b7afccb3bc8bfabc30c8fe82b38eb10::vault::borrow_sui(arg0, arg1, arg3, arg5), arg5);
        assert!(0x2::coin::value<0xe4795695a8baf9508250d2a964842ad19b7afccb3bc8bfabc30c8fe82b38eb10::mock_dex::MOCK_DEX>(&v0) >= arg4, 3);
        0xe4795695a8baf9508250d2a964842ad19b7afccb3bc8bfabc30c8fe82b38eb10::vault::return_MOCK_DEX(arg0, v0);
    }

    public fun flash_borrow_MOCK_DEX(arg0: &mut 0xe4795695a8baf9508250d2a964842ad19b7afccb3bc8bfabc30c8fe82b38eb10::vault::Vault, arg1: &mut 0xe4795695a8baf9508250d2a964842ad19b7afccb3bc8bfabc30c8fe82b38eb10::agent_cap::AgentCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0xe4795695a8baf9508250d2a964842ad19b7afccb3bc8bfabc30c8fe82b38eb10::mock_dex::MOCK_DEX>, ActionReceipt) {
        let v0 = ActionReceipt{
            vault_id        : 0x2::object::id<0xe4795695a8baf9508250d2a964842ad19b7afccb3bc8bfabc30c8fe82b38eb10::vault::Vault>(arg0),
            borrowed_amount : arg2,
            is_sui          : false,
        };
        (0xe4795695a8baf9508250d2a964842ad19b7afccb3bc8bfabc30c8fe82b38eb10::vault::borrow_MOCK_DEX(arg0, arg1, arg2, arg3), v0)
    }

    public fun flash_borrow_sui(arg0: &mut 0xe4795695a8baf9508250d2a964842ad19b7afccb3bc8bfabc30c8fe82b38eb10::vault::Vault, arg1: &mut 0xe4795695a8baf9508250d2a964842ad19b7afccb3bc8bfabc30c8fe82b38eb10::agent_cap::AgentCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, ActionReceipt) {
        let v0 = ActionReceipt{
            vault_id        : 0x2::object::id<0xe4795695a8baf9508250d2a964842ad19b7afccb3bc8bfabc30c8fe82b38eb10::vault::Vault>(arg0),
            borrowed_amount : arg2,
            is_sui          : true,
        };
        (0xe4795695a8baf9508250d2a964842ad19b7afccb3bc8bfabc30c8fe82b38eb10::vault::borrow_sui(arg0, arg1, arg2, arg3), v0)
    }

    public fun flash_return_MOCK_DEX(arg0: &mut 0xe4795695a8baf9508250d2a964842ad19b7afccb3bc8bfabc30c8fe82b38eb10::vault::Vault, arg1: ActionReceipt, arg2: 0x2::coin::Coin<0xe4795695a8baf9508250d2a964842ad19b7afccb3bc8bfabc30c8fe82b38eb10::mock_dex::MOCK_DEX>) {
        let ActionReceipt {
            vault_id        : v0,
            borrowed_amount : _,
            is_sui          : v2,
        } = arg1;
        assert!(v0 == 0x2::object::id<0xe4795695a8baf9508250d2a964842ad19b7afccb3bc8bfabc30c8fe82b38eb10::vault::Vault>(arg0), 1);
        assert!(!v2, 2);
        0xe4795695a8baf9508250d2a964842ad19b7afccb3bc8bfabc30c8fe82b38eb10::vault::return_MOCK_DEX(arg0, arg2);
    }

    public fun flash_return_sui(arg0: &mut 0xe4795695a8baf9508250d2a964842ad19b7afccb3bc8bfabc30c8fe82b38eb10::vault::Vault, arg1: ActionReceipt, arg2: 0x2::coin::Coin<0x2::sui::SUI>) {
        let ActionReceipt {
            vault_id        : v0,
            borrowed_amount : _,
            is_sui          : v2,
        } = arg1;
        assert!(v0 == 0x2::object::id<0xe4795695a8baf9508250d2a964842ad19b7afccb3bc8bfabc30c8fe82b38eb10::vault::Vault>(arg0), 1);
        assert!(v2, 2);
        0xe4795695a8baf9508250d2a964842ad19b7afccb3bc8bfabc30c8fe82b38eb10::vault::return_sui(arg0, arg2);
    }

    // decompiled from Move bytecode v7
}

