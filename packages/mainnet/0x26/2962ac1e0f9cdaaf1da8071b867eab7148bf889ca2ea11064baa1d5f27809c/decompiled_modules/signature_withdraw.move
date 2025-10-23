module 0x66cfd822a8c64bf47ab75620505434acf627b21b0249cbedc581c4d127d60a1f::signature_withdraw {
    struct SIGNATURE_WITHDRAW has drop {
        dummy_field: bool,
    }

    struct WithdrawState has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        owner: address,
        nonce: u64,
        public_key: vector<u8>,
    }

    struct WithdrawEvent has copy, drop {
        amount: u64,
        recipient: address,
        timestamp: u64,
    }

    fun create_withdraw_message(arg0: u64, arg1: address, arg2: u64, arg3: u64) : vector<u8> {
        let v0 = b"SUI_WITHDRAW:";
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg0));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<address>(&arg1));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg2));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg3));
        v0
    }

    public fun create_withdraw_state(arg0: vector<u8>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = WithdrawState{
            id         : 0x2::object::new(arg1),
            balance    : 0x2::balance::zero<0x2::sui::SUI>(),
            owner      : 0x2::tx_context::sender(arg1),
            nonce      : 0,
            public_key : arg0,
        };
        0x2::transfer::share_object<WithdrawState>(v0);
    }

    public fun deposit(arg0: &mut WithdrawState, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.balance, arg1);
        let v0 = WithdrawEvent{
            amount    : 0x2::coin::value<0x2::sui::SUI>(&arg1),
            recipient : @0x0,
            timestamp : 0,
        };
        0x2::event::emit<WithdrawEvent>(v0);
    }

    public fun get_balance(arg0: &WithdrawState) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    public fun get_nonce(arg0: &WithdrawState) : u64 {
        arg0.nonce
    }

    fun init(arg0: SIGNATURE_WITHDRAW, arg1: &mut 0x2::tx_context::TxContext) {
    }

    public fun withdraw(arg0: &mut WithdrawState, arg1: u64, arg2: address, arg3: vector<u8>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg4 >= 0x2::clock::timestamp_ms(arg5) / 1000, 2);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.balance) >= arg1, 4);
        let v0 = create_withdraw_message(arg1, arg2, arg0.nonce, arg4);
        assert!(0x2::ed25519::ed25519_verify(&arg3, &arg0.public_key, &v0), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, arg1, arg6), arg2);
        arg0.nonce = arg0.nonce + 1;
        let v1 = WithdrawEvent{
            amount    : arg1,
            recipient : arg2,
            timestamp : arg4,
        };
        0x2::event::emit<WithdrawEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

