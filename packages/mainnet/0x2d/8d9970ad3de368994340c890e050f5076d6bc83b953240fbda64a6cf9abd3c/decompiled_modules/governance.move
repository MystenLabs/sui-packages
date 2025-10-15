module 0x2d8d9970ad3de368994340c890e050f5076d6bc83b953240fbda64a6cf9abd3c::governance {
    struct ChangePubkeyRequest has key {
        id: 0x2::object::UID,
        new_pubkey: vector<u8>,
        voters: vector<address>,
        deadline: u64,
        is_executed: bool,
    }

    struct WithDrawRequest has key {
        id: 0x2::object::UID,
        to: address,
        amount: u64,
        voters: vector<address>,
        deadline: u64,
        is_executed: bool,
    }

    public fun create_change_pubkey_request<T0>(arg0: &0x2d8d9970ad3de368994340c890e050f5076d6bc83b953240fbda64a6cf9abd3c::sweepstake::Treasury<T0>, arg1: vector<u8>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2d8d9970ad3de368994340c890e050f5076d6bc83b953240fbda64a6cf9abd3c::sweepstake::is_treasury_admin<T0>(arg0, 0x2::tx_context::sender(arg3)), 257);
        let v0 = ChangePubkeyRequest{
            id          : 0x2::object::new(arg3),
            new_pubkey  : arg1,
            voters      : vector[],
            deadline    : arg2,
            is_executed : false,
        };
        0x2::transfer::share_object<ChangePubkeyRequest>(v0);
    }

    public fun create_withdraw_request<T0>(arg0: &0x2d8d9970ad3de368994340c890e050f5076d6bc83b953240fbda64a6cf9abd3c::sweepstake::Treasury<T0>, arg1: address, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2d8d9970ad3de368994340c890e050f5076d6bc83b953240fbda64a6cf9abd3c::sweepstake::is_treasury_admin<T0>(arg0, 0x2::tx_context::sender(arg4)), 257);
        let v0 = WithDrawRequest{
            id          : 0x2::object::new(arg4),
            to          : arg1,
            amount      : arg2,
            voters      : 0x1::vector::empty<address>(),
            deadline    : arg3,
            is_executed : false,
        };
        0x2::transfer::share_object<WithDrawRequest>(v0);
    }

    public fun execute_change_pubkey<T0>(arg0: &mut 0x2d8d9970ad3de368994340c890e050f5076d6bc83b953240fbda64a6cf9abd3c::sweepstake::Treasury<T0>, arg1: &mut ChangePubkeyRequest, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2d8d9970ad3de368994340c890e050f5076d6bc83b953240fbda64a6cf9abd3c::sweepstake::is_treasury_admin<T0>(arg0, 0x2::tx_context::sender(arg2)), 257);
        assert!(!arg1.is_executed, 258);
        assert!(0x1::vector::length<address>(&arg1.voters) > 2 * 0x2d8d9970ad3de368994340c890e050f5076d6bc83b953240fbda64a6cf9abd3c::sweepstake::num_treasury_admins<T0>(arg0) / 3, 259);
        0x2d8d9970ad3de368994340c890e050f5076d6bc83b953240fbda64a6cf9abd3c::sweepstake::set_treasury_pubkey<T0>(arg0, arg1.new_pubkey);
        arg1.is_executed = true;
    }

    public fun execute_withdraw<T0>(arg0: &mut 0x2d8d9970ad3de368994340c890e050f5076d6bc83b953240fbda64a6cf9abd3c::sweepstake::Treasury<T0>, arg1: &mut WithDrawRequest, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.is_executed, 258);
        assert!(0x1::vector::length<address>(&arg1.voters) > 2 * 0x2d8d9970ad3de368994340c890e050f5076d6bc83b953240fbda64a6cf9abd3c::sweepstake::num_treasury_admins<T0>(arg0) / 3, 259);
        0x2d8d9970ad3de368994340c890e050f5076d6bc83b953240fbda64a6cf9abd3c::sweepstake::withdraw_from_treasury<T0>(arg0, arg1.to, arg1.amount, arg2);
        arg1.is_executed = true;
    }

    public fun vote_change_pubkey<T0>(arg0: &0x2d8d9970ad3de368994340c890e050f5076d6bc83b953240fbda64a6cf9abd3c::sweepstake::Treasury<T0>, arg1: &mut ChangePubkeyRequest, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1.deadline > 0x2::clock::timestamp_ms(arg2), 256);
        assert!(0x2d8d9970ad3de368994340c890e050f5076d6bc83b953240fbda64a6cf9abd3c::sweepstake::is_treasury_admin<T0>(arg0, 0x2::tx_context::sender(arg3)), 257);
        0x1::vector::push_back<address>(&mut arg1.voters, 0x2::tx_context::sender(arg3));
    }

    public fun vote_withdraw<T0>(arg0: &0x2d8d9970ad3de368994340c890e050f5076d6bc83b953240fbda64a6cf9abd3c::sweepstake::Treasury<T0>, arg1: &mut WithDrawRequest, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1.deadline > 0x2::clock::timestamp_ms(arg2), 256);
        assert!(0x2d8d9970ad3de368994340c890e050f5076d6bc83b953240fbda64a6cf9abd3c::sweepstake::is_treasury_admin<T0>(arg0, 0x2::tx_context::sender(arg3)), 257);
        0x1::vector::push_back<address>(&mut arg1.voters, 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

