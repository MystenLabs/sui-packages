module 0xda1d5fa5572f75e3724a1cf876562497d5319787e5af5383ee25377176beae13::events {
    struct Event<T0: copy + drop> has copy, drop {
        pos0: T0,
    }

    struct WalletAdded has copy, drop {
        app: 0x1::type_name::TypeName,
        dwallet: address,
        dwallet_cap: address,
        dwallet_network_encryption_key_id: 0x2::object::ID,
        wallet_key: u64,
        curve: u32,
        hash_scheme: u32,
        signature_algorithm: u32,
    }

    struct PresignAdded has copy, drop {
        app: 0x1::type_name::TypeName,
        dwallet: address,
        dwallet_cap: address,
    }

    struct BalanceIncremented has copy, drop {
        app: 0x1::type_name::TypeName,
        digest: vector<u8>,
        wallet_key: u64,
        user: address,
        chain_id: u64,
        token: vector<u8>,
        amount: u256,
        new_balance: u256,
        dwallet: address,
        dwallet_cap: address,
    }

    struct BalanceDecremented has copy, drop {
        app: 0x1::type_name::TypeName,
        wallet_key: u64,
        user: address,
        chain_id: u64,
        token: vector<u8>,
        amount: u256,
        new_balance: u256,
        message_centralized_signature: vector<u8>,
        message: vector<u8>,
        sign_id: 0x2::object::ID,
        dwallet: address,
        dwallet_cap: address,
    }

    struct AppInitialized has copy, drop {
        app: 0x1::type_name::TypeName,
    }

    struct SignRequested has copy, drop {
        app: 0x1::type_name::TypeName,
        wallet_key: u64,
        message_centralized_signature: vector<u8>,
        message: vector<u8>,
        sign_id: 0x2::object::ID,
        dwallet: address,
        dwallet_cap: address,
    }

    public(friend) fun emit_app_initialized(arg0: 0x1::type_name::TypeName) {
        let v0 = AppInitialized{app: arg0};
        let v1 = Event<AppInitialized>{pos0: v0};
        0x2::event::emit<Event<AppInitialized>>(v1);
    }

    public(friend) fun emit_decrement_balance(arg0: 0x1::type_name::TypeName, arg1: u64, arg2: address, arg3: u64, arg4: vector<u8>, arg5: u256, arg6: u256, arg7: vector<u8>, arg8: vector<u8>, arg9: 0x2::object::ID, arg10: address, arg11: address) {
        let v0 = BalanceDecremented{
            app                           : arg0,
            wallet_key                    : arg1,
            user                          : arg2,
            chain_id                      : arg3,
            token                         : arg4,
            amount                        : arg5,
            new_balance                   : arg6,
            message_centralized_signature : arg7,
            message                       : arg8,
            sign_id                       : arg9,
            dwallet                       : arg10,
            dwallet_cap                   : arg11,
        };
        let v1 = Event<BalanceDecremented>{pos0: v0};
        0x2::event::emit<Event<BalanceDecremented>>(v1);
    }

    public(friend) fun emit_increment_balance(arg0: 0x1::type_name::TypeName, arg1: vector<u8>, arg2: u64, arg3: address, arg4: u64, arg5: vector<u8>, arg6: u256, arg7: u256, arg8: address, arg9: address) {
        let v0 = BalanceIncremented{
            app         : arg0,
            digest      : arg1,
            wallet_key  : arg2,
            user        : arg3,
            chain_id    : arg4,
            token       : arg5,
            amount      : arg6,
            new_balance : arg7,
            dwallet     : arg8,
            dwallet_cap : arg9,
        };
        let v1 = Event<BalanceIncremented>{pos0: v0};
        0x2::event::emit<Event<BalanceIncremented>>(v1);
    }

    public(friend) fun emit_presign_added(arg0: 0x1::type_name::TypeName, arg1: address, arg2: address) {
        let v0 = PresignAdded{
            app         : arg0,
            dwallet     : arg1,
            dwallet_cap : arg2,
        };
        let v1 = Event<PresignAdded>{pos0: v0};
        0x2::event::emit<Event<PresignAdded>>(v1);
    }

    public(friend) fun emit_sign_requested(arg0: 0x1::type_name::TypeName, arg1: u64, arg2: vector<u8>, arg3: vector<u8>, arg4: 0x2::object::ID, arg5: address, arg6: address) {
        let v0 = SignRequested{
            app                           : arg0,
            wallet_key                    : arg1,
            message_centralized_signature : arg2,
            message                       : arg3,
            sign_id                       : arg4,
            dwallet                       : arg5,
            dwallet_cap                   : arg6,
        };
        let v1 = Event<SignRequested>{pos0: v0};
        0x2::event::emit<Event<SignRequested>>(v1);
    }

    public(friend) fun emit_wallet_added(arg0: 0x1::type_name::TypeName, arg1: address, arg2: address, arg3: 0x2::object::ID, arg4: u64, arg5: u32, arg6: u32, arg7: u32) {
        let v0 = WalletAdded{
            app                               : arg0,
            dwallet                           : arg1,
            dwallet_cap                       : arg2,
            dwallet_network_encryption_key_id : arg3,
            wallet_key                        : arg4,
            curve                             : arg5,
            hash_scheme                       : arg6,
            signature_algorithm               : arg7,
        };
        let v1 = Event<WalletAdded>{pos0: v0};
        0x2::event::emit<Event<WalletAdded>>(v1);
    }

    // decompiled from Move bytecode v6
}

