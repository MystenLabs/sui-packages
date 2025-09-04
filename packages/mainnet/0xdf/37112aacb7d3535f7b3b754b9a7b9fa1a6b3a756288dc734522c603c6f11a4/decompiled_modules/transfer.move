module 0xdf37112aacb7d3535f7b3b754b9a7b9fa1a6b3a756288dc734522c603c6f11a4::transfer {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Config has key {
        id: 0x2::object::UID,
        fee_collector: address,
        gas_drop_collector: address,
        fee_bp: u64,
        nonce: u256,
        processed_cctp_nonces: 0x2::table::Table<u64, bool>,
        signer_key: vector<u8>,
        max_usdc_gas_drop: u64,
        max_native_gas_drop: u64,
        paused: bool,
    }

    struct TransferParams has copy, drop {
        local_domain: u32,
        destination_domain: u32,
        fee: u64,
        deadline: u64,
        fee_is_native: bool,
    }

    struct CashmereTransfer has copy, drop {
        destination_domain: u32,
        nonce: u256,
        recipient: address,
        solana_owner: address,
        user: address,
        amount: u64,
        gas_drop_amount: u64,
        fee_is_native: bool,
        cctp_nonce: u256,
    }

    struct DepositInfo has drop {
        initial_amount: u64,
        solana_owner: address,
        user: address,
        gas_drop_amount: u64,
        fee_is_native: bool,
    }

    struct Auth has drop {
        dummy_field: bool,
    }

    public fun get_fee(arg0: &Config, arg1: u64, arg2: u64) : u64 {
        arg1 * arg0.fee_bp / 10000 + arg2
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            id                    : 0x2::object::new(arg0),
            fee_collector         : 0x2::tx_context::sender(arg0),
            gas_drop_collector    : 0x2::tx_context::sender(arg0),
            fee_bp                : 1,
            nonce                 : 0,
            processed_cctp_nonces : 0x2::table::new<u64, bool>(arg0),
            signer_key            : b"",
            max_usdc_gas_drop     : 100000000,
            max_native_gas_drop   : 0,
            paused                : false,
        };
        0x2::transfer::share_object<Config>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun post_deposit_for_burn(arg0: 0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::burn_message::BurnMessage, arg1: 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::message::Message, arg2: DepositInfo, arg3: &mut Config) {
        assert!(!0x2::table::contains<u64, bool>(&arg3.processed_cctp_nonces, 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::message::nonce(&arg1)), 4101);
        0x2::table::add<u64, bool>(&mut arg3.processed_cctp_nonces, 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::message::nonce(&arg1), true);
        arg3.nonce = arg3.nonce + 1;
        let v0 = CashmereTransfer{
            destination_domain : 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::message::destination_domain(&arg1),
            nonce              : arg3.nonce,
            recipient          : 0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::burn_message::mint_recipient(&arg0),
            solana_owner       : arg2.solana_owner,
            user               : arg2.user,
            amount             : arg2.initial_amount,
            gas_drop_amount    : arg2.gas_drop_amount,
            fee_is_native      : arg2.fee_is_native,
            cctp_nonce         : (0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::message::nonce(&arg1) as u256),
        };
        0x2::event::emit<CashmereTransfer>(v0);
    }

    public fun prepare_deposit_for_burn_ticket<T0: drop>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u32, arg3: address, arg4: address, arg5: u64, arg6: u64, arg7: u64, arg8: bool, arg9: vector<u8>, arg10: &Config, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : (0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::deposit_for_burn::DepositForBurnTicket<T0, Auth>, DepositInfo) {
        assert!(!arg10.paused, 4102);
        let v0 = if (arg7 > 0 && arg8) {
            0x2::coin::split<0x2::sui::SUI>(&mut arg1, arg7, arg12)
        } else {
            0x2::coin::zero<0x2::sui::SUI>(arg12)
        };
        let v1 = if (arg7 > 0 && !arg8) {
            0x2::coin::split<T0>(&mut arg0, arg7, arg12)
        } else {
            0x2::coin::zero<T0>(arg12)
        };
        let v2 = 0x2::coin::value<T0>(&arg0);
        let v3 = if (arg8) {
            0
        } else {
            arg5
        };
        let v4 = get_fee(arg10, v2, v3);
        assert!(v4 <= v2, 4099);
        if (arg8) {
            assert!(arg7 <= arg10.max_native_gas_drop, 4098);
        } else {
            assert!(arg7 <= arg10.max_usdc_gas_drop, 4098);
        };
        let v5 = TransferParams{
            local_domain       : 8,
            destination_domain : arg2,
            fee                : arg5,
            deadline           : arg6,
            fee_is_native      : arg8,
        };
        let v6 = 0x2::bcs::to_bytes<TransferParams>(&v5);
        assert!(0x2::ed25519::ed25519_verify(&arg9, &arg10.signer_key, &v6), 4096);
        assert!(arg6 >= 0x2::clock::timestamp_ms(arg11) / 1000, 4097);
        if (v4 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0, v4, arg12), arg10.fee_collector);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, arg10.gas_drop_collector);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, arg10.gas_drop_collector);
        if (arg8) {
            assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= arg5, 4100);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, arg5, arg12), arg10.fee_collector);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, 0x2::tx_context::sender(arg12));
        let v7 = Auth{dummy_field: false};
        let v8 = DepositInfo{
            initial_amount  : v2,
            solana_owner    : arg4,
            user            : 0x2::tx_context::sender(arg12),
            gas_drop_amount : arg7,
            fee_is_native   : arg8,
        };
        (0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::deposit_for_burn::create_deposit_for_burn_ticket<T0, Auth>(v7, arg0, arg2, arg3), v8)
    }

    public fun set_fee_bp(arg0: &AdminCap, arg1: &mut Config, arg2: u64) {
        assert!(arg2 <= 100, 8192);
        arg1.fee_bp = arg2;
    }

    public fun set_fee_collector(arg0: &AdminCap, arg1: &mut Config, arg2: address) {
        arg1.fee_collector = arg2;
    }

    public fun set_gas_drop_collector(arg0: &AdminCap, arg1: &mut Config, arg2: address) {
        arg1.gas_drop_collector = arg2;
    }

    public fun set_max_native_gas_drop(arg0: &AdminCap, arg1: &mut Config, arg2: u64) {
        arg1.max_native_gas_drop = arg2;
    }

    public fun set_max_usdc_gas_drop(arg0: &AdminCap, arg1: &mut Config, arg2: u64) {
        arg1.max_usdc_gas_drop = arg2;
    }

    public fun set_paused(arg0: &AdminCap, arg1: &mut Config, arg2: bool) {
        arg1.paused = arg2;
    }

    public fun set_signer_key(arg0: &AdminCap, arg1: &mut Config, arg2: vector<u8>) {
        arg1.signer_key = arg2;
    }

    // decompiled from Move bytecode v6
}

