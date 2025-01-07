module 0x4b34b89b58ad48bf1dc7d768f0b9504db0c5608f336f51f25b6089572fc8e72d::cross {
    struct CrossCap has key {
        id: 0x2::object::UID,
    }

    struct BridgeConfig<phantom T0> has store, key {
        id: 0x2::object::UID,
        fee: u64,
        min: u64,
        max: u64,
        ratio: u64,
        fee_balance: 0x2::balance::Balance<T0>,
        burn_balance: 0x2::balance::Balance<T0>,
        token_balance: 0x2::balance::Balance<T0>,
        token: 0x1::type_name::TypeName,
        evm_chain_id: u64,
        evm_token: 0x1::string::String,
        reg_fee: bool,
        outer_fee: bool,
        digest_delivered: 0x2::table::Table<0x1::string::String, bool>,
        from_burn: bool,
        to_mint: bool,
        version: u64,
    }

    struct Swap has copy, drop {
        bc_id: 0x2::object::ID,
        from: address,
        to: 0x1::string::String,
        from_amount: u64,
        to_amount: u64,
        fee: u64,
        evm_chain_id: u64,
        evm_token: 0x1::string::String,
    }

    struct Deliver has copy, drop {
        bc_id: 0x2::object::ID,
        to: address,
        amount: u64,
        evm_chain_id: u64,
        digest: 0x1::string::String,
    }

    public entry fun swap<T0>(arg0: &mut BridgeConfig<T0>, arg1: &mut 0x2::coin::Coin<T0>, arg2: u64, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 0);
        assert!(arg0.token == 0x1::type_name::get<T0>(), 1);
        assert!(arg2 >= arg0.min && arg2 <= arg0.max, 2);
        let v0 = arg0.fee;
        let v1 = v0;
        if (!arg0.reg_fee) {
            v1 = arg2 * v0 / 10000;
        };
        let v2 = arg2;
        if (arg0.outer_fee) {
            v2 = arg2 + v1;
        };
        let v3 = 0x2::coin::balance_mut<T0>(arg1);
        if (v1 > 0) {
            0x2::balance::join<T0>(&mut arg0.fee_balance, 0x2::balance::split<T0>(v3, v1));
        };
        if (arg0.from_burn) {
            0x2::balance::join<T0>(&mut arg0.burn_balance, 0x2::balance::split<T0>(v3, arg2 - v1));
        } else {
            0x2::balance::join<T0>(&mut arg0.token_balance, 0x2::balance::split<T0>(v3, arg2 - v1));
        };
        let v4 = Swap{
            bc_id        : *0x2::object::uid_as_inner(&arg0.id),
            from         : 0x2::tx_context::sender(arg4),
            to           : 0x1::string::utf8(arg3),
            from_amount  : v2,
            to_amount    : (v2 - v1) * arg0.ratio / 10000,
            fee          : v1,
            evm_chain_id : arg0.evm_chain_id,
            evm_token    : arg0.evm_token,
        };
        0x2::event::emit<Swap>(v4);
    }

    public entry fun add_balance_for_deliver<T0>(arg0: &mut CrossCap, arg1: &mut BridgeConfig<T0>, arg2: &mut 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<T0>(&mut arg1.token_balance, 0x2::balance::split<T0>(0x2::coin::balance_mut<T0>(arg2), arg3));
    }

    public entry fun burn_balance<T0>(arg0: &mut CrossCap, arg1: &mut BridgeConfig<T0>, arg2: &mut 0x2::coin::TreasuryCap<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<T0>(arg2, 0x2::coin::take<T0>(&mut arg1.burn_balance, 0x2::balance::value<T0>(&arg1.burn_balance), arg3));
    }

    public entry fun create_bc<T0>(arg0: &mut CrossCap, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: vector<u8>, arg7: bool, arg8: bool, arg9: bool, arg10: bool, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = BridgeConfig<T0>{
            id               : 0x2::object::new(arg11),
            fee              : arg1,
            min              : arg2,
            max              : arg3,
            ratio            : arg4,
            fee_balance      : 0x2::balance::zero<T0>(),
            burn_balance     : 0x2::balance::zero<T0>(),
            token_balance    : 0x2::balance::zero<T0>(),
            token            : 0x1::type_name::get<T0>(),
            evm_chain_id     : arg5,
            evm_token        : 0x1::string::utf8(arg6),
            reg_fee          : arg7,
            outer_fee        : arg8,
            digest_delivered : 0x2::table::new<0x1::string::String, bool>(arg11),
            from_burn        : arg9,
            to_mint          : arg10,
            version          : 1,
        };
        0x2::transfer::share_object<BridgeConfig<T0>>(v0);
    }

    public entry fun deliver_mint<T0>(arg0: &mut CrossCap, arg1: &mut BridgeConfig<T0>, arg2: &mut 0x2::coin::TreasuryCap<T0>, arg3: u64, arg4: vector<u8>, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(arg4);
        valid_deliver<T0>(arg1, v0);
        assert!(arg1.to_mint, 2);
        0x2::table::add<0x1::string::String, bool>(&mut arg1.digest_delivered, v0, true);
        0x2::coin::mint_and_transfer<T0>(arg2, arg3, arg5, arg6);
        let v1 = Deliver{
            bc_id        : *0x2::object::uid_as_inner(&arg1.id),
            to           : arg5,
            amount       : arg3,
            evm_chain_id : arg1.evm_chain_id,
            digest       : 0x1::string::utf8(arg4),
        };
        0x2::event::emit<Deliver>(v1);
    }

    public entry fun deliver_transfer<T0>(arg0: &mut CrossCap, arg1: &mut BridgeConfig<T0>, arg2: u64, arg3: vector<u8>, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(arg3);
        valid_deliver<T0>(arg1, v0);
        assert!(!arg1.to_mint, 2);
        0x2::table::add<0x1::string::String, bool>(&mut arg1.digest_delivered, v0, true);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.token_balance, arg2, arg5), arg4);
        let v1 = Deliver{
            bc_id        : *0x2::object::uid_as_inner(&arg1.id),
            to           : arg4,
            amount       : arg2,
            evm_chain_id : arg1.evm_chain_id,
            digest       : 0x1::string::utf8(arg3),
        };
        0x2::event::emit<Deliver>(v1);
    }

    public fun digest_delivered<T0>(arg0: &BridgeConfig<T0>, arg1: vector<u8>) : bool {
        0x2::table::contains<0x1::string::String, bool>(&arg0.digest_delivered, 0x1::string::utf8(arg1))
    }

    public fun get_amounts_out<T0>(arg0: &BridgeConfig<T0>, arg1: u64) : (0x1::type_name::TypeName, u64, u64) {
        let v0 = arg0.fee;
        let v1 = v0;
        if (arg1 <= v0) {
            (arg0.token, 0, 0)
        } else {
            if (!arg0.reg_fee) {
                v1 = arg1 * v0 / 10000;
            };
            let v5 = arg1;
            if (arg0.outer_fee) {
                v5 = arg1 + v1;
            };
            (arg0.token, v5, (v5 - v1) * arg0.ratio / 10000)
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = CrossCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<CrossCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun migrate<T0>(arg0: &mut CrossCap, arg1: &mut BridgeConfig<T0>) {
        assert!(arg1.version < 1, 0);
        arg1.version = 1;
    }

    public entry fun take_fee_balance<T0>(arg0: &mut CrossCap, arg1: &mut BridgeConfig<T0>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.fee_balance, arg2), arg4), arg3);
    }

    public entry fun take_token_balance<T0>(arg0: &mut CrossCap, arg1: &mut BridgeConfig<T0>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.token_balance, arg2), arg4), arg3);
    }

    public entry fun update_bc<T0>(arg0: &mut CrossCap, arg1: &mut BridgeConfig<T0>, arg2: u64, arg3: u64, arg4: u64, arg5: bool, arg6: bool, arg7: bool, arg8: bool) {
        arg1.fee = arg2;
        arg1.min = arg3;
        arg1.max = arg4;
        arg1.reg_fee = arg5;
        arg1.outer_fee = arg6;
        arg1.from_burn = arg7;
        arg1.to_mint = arg8;
    }

    entry fun valid_deliver<T0>(arg0: &mut BridgeConfig<T0>, arg1: 0x1::string::String) {
        assert!(arg0.version == 1, 0);
        assert!(!0x2::table::contains<0x1::string::String, bool>(&arg0.digest_delivered, arg1), 1);
    }

    // decompiled from Move bytecode v6
}

