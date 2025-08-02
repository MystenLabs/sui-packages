module 0x5abe7a273c93a3d3288a8f5721046970f7577081c593645f5f0887c81bd8c869::escrow_dst {
    struct EscrowDst<phantom T0> has key {
        id: 0x2::object::UID,
        maker: address,
        taker: address,
        balance: 0x2::balance::Balance<T0>,
        safety_deposit: 0x2::balance::Balance<0x2::sui::SUI>,
        hash_lock: vector<u8>,
        withdrawal_time: u64,
        public_withdrawal_time: u64,
        cancellation_time: u64,
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

    public fun can_cancel<T0>(arg0: &EscrowDst<T0>, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) >= arg0.cancellation_time
    }

    public fun can_public_withdraw<T0>(arg0: &EscrowDst<T0>, arg1: &0x2::clock::Clock) : bool {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        v0 >= arg0.public_withdrawal_time && v0 < arg0.cancellation_time
    }

    public fun can_withdraw<T0>(arg0: &EscrowDst<T0>, arg1: &0x2::clock::Clock) : bool {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        v0 >= arg0.withdrawal_time && v0 < arg0.cancellation_time
    }

    public fun cancel<T0>(arg0: EscrowDst<T0>, arg1: &0x5abe7a273c93a3d3288a8f5721046970f7577081c593645f5f0887c81bd8c869::capabilities::ResolverCap, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == arg0.taker, 0x5abe7a273c93a3d3288a8f5721046970f7577081c593645f5f0887c81bd8c869::errors::only_taker());
        assert!(0x2::clock::timestamp_ms(arg2) >= arg0.cancellation_time, 0x5abe7a273c93a3d3288a8f5721046970f7577081c593645f5f0887c81bd8c869::errors::contract_not_expired());
        let EscrowDst {
            id                     : v1,
            maker                  : _,
            taker                  : v3,
            balance                : v4,
            safety_deposit         : v5,
            hash_lock              : _,
            withdrawal_time        : _,
            public_withdrawal_time : _,
            cancellation_time      : _,
            created_at             : _,
        } = arg0;
        let v11 = v4;
        let v12 = v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v11, arg3), v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v5, arg3), v0);
        let v13 = EscrowCancelled{
            escrow_id : 0x2::object::uid_to_inner(&v12),
            canceller : v0,
            amount    : 0x2::balance::value<T0>(&v11),
        };
        0x2::event::emit<EscrowCancelled>(v13);
        0x2::object::delete(v12);
    }

    public entry fun create_dst_escrow<T0>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: address, arg3: vector<u8>, arg4: &0x5abe7a273c93a3d3288a8f5721046970f7577081c593645f5f0887c81bd8c869::capabilities::ResolverCap, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        0x2::transfer::share_object<EscrowDst<T0>>(new_escrow_dst<T0>(0x2::coin::into_balance<T0>(arg0), 0x2::coin::into_balance<0x2::sui::SUI>(arg1), arg2, v0, arg3, arg5, arg6));
    }

    public fun get_escrow_id<T0>(arg0: &EscrowDst<T0>) : &0x2::object::UID {
        &arg0.id
    }

    public fun get_escrow_info<T0>(arg0: &EscrowDst<T0>) : (address, address, u64, u64, vector<u8>, u64, u64, u64, u64) {
        (arg0.maker, arg0.taker, 0x2::balance::value<T0>(&arg0.balance), 0x2::balance::value<0x2::sui::SUI>(&arg0.safety_deposit), arg0.hash_lock, arg0.withdrawal_time, arg0.public_withdrawal_time, arg0.cancellation_time, arg0.created_at)
    }

    fun new_escrow_dst<T0>(arg0: 0x2::balance::Balance<T0>, arg1: 0x2::balance::Balance<0x2::sui::SUI>, arg2: address, arg3: address, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : EscrowDst<T0> {
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = EscrowDst<T0>{
            id                     : 0x2::object::new(arg6),
            maker                  : arg2,
            taker                  : arg3,
            balance                : arg0,
            safety_deposit         : arg1,
            hash_lock              : arg4,
            withdrawal_time        : v0 + 15000,
            public_withdrawal_time : v0 + 7200000,
            cancellation_time      : v0 + 10800000,
            created_at             : v0,
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

    public fun public_withdraw<T0>(arg0: EscrowDst<T0>, arg1: vector<u8>, arg2: &0x5abe7a273c93a3d3288a8f5721046970f7577081c593645f5f0887c81bd8c869::capabilities::ResolverCap, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        assert!(v1 >= arg0.public_withdrawal_time, 0x5abe7a273c93a3d3288a8f5721046970f7577081c593645f5f0887c81bd8c869::errors::contract_not_expired());
        assert!(v1 < arg0.cancellation_time, 0x5abe7a273c93a3d3288a8f5721046970f7577081c593645f5f0887c81bd8c869::errors::contract_expired());
        assert!(0x2::hash::keccak256(&arg1) == arg0.hash_lock, 0x5abe7a273c93a3d3288a8f5721046970f7577081c593645f5f0887c81bd8c869::errors::invalid_secret());
        let EscrowDst {
            id                     : v2,
            maker                  : v3,
            taker                  : _,
            balance                : v5,
            safety_deposit         : v6,
            hash_lock              : _,
            withdrawal_time        : _,
            public_withdrawal_time : _,
            cancellation_time      : _,
            created_at             : _,
        } = arg0;
        let v12 = v5;
        let v13 = v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v12, arg4), v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v6, arg4), v0);
        let v14 = PublicWithdrawal{
            escrow_id  : 0x2::object::uid_to_inner(&v13),
            withdrawer : v0,
            secret     : arg1,
            amount     : 0x2::balance::value<T0>(&v12),
        };
        0x2::event::emit<PublicWithdrawal>(v14);
        0x2::object::delete(v13);
    }

    public fun withdraw<T0>(arg0: EscrowDst<T0>, arg1: vector<u8>, arg2: &0x5abe7a273c93a3d3288a8f5721046970f7577081c593645f5f0887c81bd8c869::capabilities::ResolverCap, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        assert!(v0 == arg0.taker, 0x5abe7a273c93a3d3288a8f5721046970f7577081c593645f5f0887c81bd8c869::errors::only_taker());
        assert!(v1 >= arg0.withdrawal_time, 0x5abe7a273c93a3d3288a8f5721046970f7577081c593645f5f0887c81bd8c869::errors::contract_not_expired());
        assert!(v1 < arg0.cancellation_time, 0x5abe7a273c93a3d3288a8f5721046970f7577081c593645f5f0887c81bd8c869::errors::contract_expired());
        assert!(0x2::hash::keccak256(&arg1) == arg0.hash_lock, 0x5abe7a273c93a3d3288a8f5721046970f7577081c593645f5f0887c81bd8c869::errors::invalid_secret());
        let EscrowDst {
            id                     : v2,
            maker                  : v3,
            taker                  : _,
            balance                : v5,
            safety_deposit         : v6,
            hash_lock              : _,
            withdrawal_time        : _,
            public_withdrawal_time : _,
            cancellation_time      : _,
            created_at             : _,
        } = arg0;
        let v12 = v5;
        let v13 = v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v12, arg4), v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v6, arg4), v0);
        let v14 = EscrowWithdrawal{
            escrow_id  : 0x2::object::uid_to_inner(&v13),
            withdrawer : v0,
            secret     : arg1,
            amount     : 0x2::balance::value<T0>(&v12),
        };
        0x2::event::emit<EscrowWithdrawal>(v14);
        0x2::object::delete(v13);
    }

    // decompiled from Move bytecode v6
}

