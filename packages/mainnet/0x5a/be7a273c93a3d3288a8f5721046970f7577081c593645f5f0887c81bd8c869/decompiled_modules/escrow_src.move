module 0x5abe7a273c93a3d3288a8f5721046970f7577081c593645f5f0887c81bd8c869::escrow_src {
    struct EscrowSrc<phantom T0> has key {
        id: 0x2::object::UID,
        maker: address,
        taker: address,
        balance: 0x2::balance::Balance<T0>,
        safety_deposit: 0x2::balance::Balance<0x2::sui::SUI>,
        hash_lock: vector<u8>,
        withdrawal_time: u64,
        public_withdrawal_time: u64,
        cancellation_time: u64,
        public_cancellation_time: u64,
        created_at: u64,
    }

    struct EscrowCreated has copy, drop {
        escrow_id: 0x2::object::ID,
        maker: address,
        taker: address,
        amount: u64,
        hash_lock: vector<u8>,
        withdrawal_time: u64,
    }

    struct EscrowWithdrawal has copy, drop {
        escrow_id: 0x2::object::ID,
        withdrawer: address,
        target: address,
        secret: vector<u8>,
        amount: u64,
    }

    struct EscrowCancelled has copy, drop {
        escrow_id: 0x2::object::ID,
        canceller: address,
        amount: u64,
    }

    struct PublicWithdrawal has copy, drop {
        escrow_id: 0x2::object::ID,
        withdrawer: address,
        secret: vector<u8>,
        amount: u64,
    }

    public fun can_cancel<T0>(arg0: &EscrowSrc<T0>, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) >= arg0.cancellation_time
    }

    public fun can_public_cancel<T0>(arg0: &EscrowSrc<T0>, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) >= arg0.public_cancellation_time
    }

    public fun can_public_withdraw<T0>(arg0: &EscrowSrc<T0>, arg1: &0x2::clock::Clock) : bool {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        v0 >= arg0.public_withdrawal_time && v0 < arg0.cancellation_time
    }

    public fun can_withdraw<T0>(arg0: &EscrowSrc<T0>, arg1: &0x2::clock::Clock) : bool {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        v0 >= arg0.withdrawal_time && v0 < arg0.cancellation_time
    }

    public fun cancel<T0>(arg0: EscrowSrc<T0>, arg1: &0x5abe7a273c93a3d3288a8f5721046970f7577081c593645f5f0887c81bd8c869::capabilities::ResolverCap, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.taker, 0x5abe7a273c93a3d3288a8f5721046970f7577081c593645f5f0887c81bd8c869::errors::only_taker());
        assert!(0x2::clock::timestamp_ms(arg2) >= arg0.cancellation_time, 0x5abe7a273c93a3d3288a8f5721046970f7577081c593645f5f0887c81bd8c869::errors::contract_not_expired());
        cancel_internal<T0>(arg0, arg3);
    }

    fun cancel_internal<T0>(arg0: EscrowSrc<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let EscrowSrc {
            id                       : v1,
            maker                    : v2,
            taker                    : _,
            balance                  : v4,
            safety_deposit           : v5,
            hash_lock                : _,
            withdrawal_time          : _,
            public_withdrawal_time   : _,
            cancellation_time        : _,
            public_cancellation_time : _,
            created_at               : _,
        } = arg0;
        let v12 = v4;
        let v13 = v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v12, arg1), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v5, arg1), v0);
        let v14 = EscrowCancelled{
            escrow_id : 0x2::object::uid_to_inner(&v13),
            canceller : v0,
            amount    : 0x2::balance::value<T0>(&v12),
        };
        0x2::event::emit<EscrowCancelled>(v14);
        0x2::object::delete(v13);
    }

    public fun get_escrow_id<T0>(arg0: &EscrowSrc<T0>) : &0x2::object::UID {
        &arg0.id
    }

    public fun get_escrow_info<T0>(arg0: &EscrowSrc<T0>) : (address, address, u64, u64, vector<u8>, u64, u64, u64, u64, u64) {
        (arg0.maker, arg0.taker, 0x2::balance::value<T0>(&arg0.balance), 0x2::balance::value<0x2::sui::SUI>(&arg0.safety_deposit), arg0.hash_lock, arg0.withdrawal_time, arg0.public_withdrawal_time, arg0.cancellation_time, arg0.public_cancellation_time, arg0.created_at)
    }

    public fun new_escrow_src<T0>(arg0: 0x2::balance::Balance<T0>, arg1: 0x2::balance::Balance<0x2::sui::SUI>, arg2: address, arg3: address, arg4: vector<u8>, arg5: &0x5abe7a273c93a3d3288a8f5721046970f7577081c593645f5f0887c81bd8c869::capabilities::ResolverCap, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : EscrowSrc<T0> {
        let v0 = 0x2::clock::timestamp_ms(arg6);
        let v1 = EscrowSrc<T0>{
            id                       : 0x2::object::new(arg7),
            maker                    : arg2,
            taker                    : arg3,
            balance                  : arg0,
            safety_deposit           : arg1,
            hash_lock                : arg4,
            withdrawal_time          : v0 + 15000,
            public_withdrawal_time   : v0 + 7200000,
            cancellation_time        : v0 + 10800000,
            public_cancellation_time : v0 + 14400000,
            created_at               : v0,
        };
        let v2 = EscrowCreated{
            escrow_id       : 0x2::object::uid_to_inner(&v1.id),
            maker           : arg2,
            taker           : arg3,
            amount          : 0x2::balance::value<T0>(&v1.balance),
            hash_lock       : arg4,
            withdrawal_time : v1.withdrawal_time,
        };
        0x2::event::emit<EscrowCreated>(v2);
        v1
    }

    public fun public_cancel<T0>(arg0: EscrowSrc<T0>, arg1: &0x5abe7a273c93a3d3288a8f5721046970f7577081c593645f5f0887c81bd8c869::capabilities::ResolverCap, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg2) >= arg0.public_cancellation_time, 0x5abe7a273c93a3d3288a8f5721046970f7577081c593645f5f0887c81bd8c869::errors::contract_not_expired());
        cancel_internal<T0>(arg0, arg3);
    }

    public fun public_withdraw<T0>(arg0: EscrowSrc<T0>, arg1: vector<u8>, arg2: &0x5abe7a273c93a3d3288a8f5721046970f7577081c593645f5f0887c81bd8c869::capabilities::ResolverCap, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        assert!(v1 >= arg0.public_withdrawal_time, 0x5abe7a273c93a3d3288a8f5721046970f7577081c593645f5f0887c81bd8c869::errors::contract_not_expired());
        assert!(v1 < arg0.cancellation_time, 0x5abe7a273c93a3d3288a8f5721046970f7577081c593645f5f0887c81bd8c869::errors::contract_expired());
        assert!(0x2::hash::keccak256(&arg1) == arg0.hash_lock, 0x5abe7a273c93a3d3288a8f5721046970f7577081c593645f5f0887c81bd8c869::errors::invalid_secret());
        let EscrowSrc {
            id                       : v2,
            maker                    : _,
            taker                    : v4,
            balance                  : v5,
            safety_deposit           : v6,
            hash_lock                : _,
            withdrawal_time          : _,
            public_withdrawal_time   : _,
            cancellation_time        : _,
            public_cancellation_time : _,
            created_at               : _,
        } = arg0;
        let v13 = v5;
        let v14 = v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v13, arg4), v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v6, arg4), v0);
        let v15 = PublicWithdrawal{
            escrow_id  : 0x2::object::uid_to_inner(&v14),
            withdrawer : v0,
            secret     : arg1,
            amount     : 0x2::balance::value<T0>(&v13),
        };
        0x2::event::emit<PublicWithdrawal>(v15);
        0x2::object::delete(v14);
    }

    public fun share_escrow_src<T0>(arg0: EscrowSrc<T0>) {
        0x2::transfer::share_object<EscrowSrc<T0>>(arg0);
    }

    public fun withdraw<T0>(arg0: EscrowSrc<T0>, arg1: vector<u8>, arg2: &0x5abe7a273c93a3d3288a8f5721046970f7577081c593645f5f0887c81bd8c869::capabilities::ResolverCap, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        withdraw_to<T0>(arg0, arg1, v0, arg2, arg3, arg4);
    }

    public fun withdraw_to<T0>(arg0: EscrowSrc<T0>, arg1: vector<u8>, arg2: address, arg3: &0x5abe7a273c93a3d3288a8f5721046970f7577081c593645f5f0887c81bd8c869::capabilities::ResolverCap, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        assert!(v0 == arg0.taker, 0x5abe7a273c93a3d3288a8f5721046970f7577081c593645f5f0887c81bd8c869::errors::only_taker());
        assert!(v1 >= arg0.withdrawal_time, 0x5abe7a273c93a3d3288a8f5721046970f7577081c593645f5f0887c81bd8c869::errors::contract_not_expired());
        assert!(v1 < arg0.cancellation_time, 0x5abe7a273c93a3d3288a8f5721046970f7577081c593645f5f0887c81bd8c869::errors::contract_expired());
        assert!(0x2::hash::keccak256(&arg1) == arg0.hash_lock, 0x5abe7a273c93a3d3288a8f5721046970f7577081c593645f5f0887c81bd8c869::errors::invalid_secret());
        let EscrowSrc {
            id                       : v2,
            maker                    : _,
            taker                    : _,
            balance                  : v5,
            safety_deposit           : v6,
            hash_lock                : _,
            withdrawal_time          : _,
            public_withdrawal_time   : _,
            cancellation_time        : _,
            public_cancellation_time : _,
            created_at               : _,
        } = arg0;
        let v13 = v5;
        let v14 = v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v13, arg5), arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v6, arg5), v0);
        let v15 = EscrowWithdrawal{
            escrow_id  : 0x2::object::uid_to_inner(&v14),
            withdrawer : v0,
            target     : arg2,
            secret     : arg1,
            amount     : 0x2::balance::value<T0>(&v13),
        };
        0x2::event::emit<EscrowWithdrawal>(v15);
        0x2::object::delete(v14);
    }

    // decompiled from Move bytecode v6
}

