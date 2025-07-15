module 0xde5031abdae03e4f2b486f50c063a38ae7b553994b99bccdc53734650635b364::drife_wallet_logic_v1 {
    struct WalletInfoV1 has store {
        user_id_onchain: vector<u8>,
        sui_address: address,
        role: vector<u8>,
        creation_timestamp: u64,
    }

    struct WalletAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct WalletState has store, key {
        id: 0x2::object::UID,
        version: u64,
        logic_id: 0x2::object::ID,
        user_wallets: 0x2::table::Table<vector<u8>, WalletInfoV1>,
        sui_address_registry: 0x2::table::Table<address, bool>,
        used_nonces: 0x2::table::Table<u64, bool>,
    }

    public(friend) fun batch_register_wallets(arg0: &WalletAdminCap, arg1: &mut WalletState, arg2: vector<vector<u8>>, arg3: vector<address>, arg4: vector<vector<u8>>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::table::contains<u64, bool>(&arg1.used_nonces, arg5), 103);
        0x2::table::add<u64, bool>(&mut arg1.used_nonces, arg5, true);
        let v0 = 0x1::vector::length<vector<u8>>(&arg2);
        assert!(v0 == 0x1::vector::length<address>(&arg3), 104);
        assert!(v0 == 0x1::vector::length<vector<u8>>(&arg4), 104);
        let v1 = 0;
        while (v1 < v0) {
            internal_create_wallet(arg1, *0x1::vector::borrow<vector<u8>>(&arg2, v1), *0x1::vector::borrow<address>(&arg3, v1), *0x1::vector::borrow<vector<u8>>(&arg4, v1), arg6);
            v1 = v1 + 1;
        };
    }

    public fun get_logic_id(arg0: &WalletState) : 0x2::object::ID {
        arg0.logic_id
    }

    public fun get_sui_address_registry(arg0: &WalletState) : &0x2::table::Table<address, bool> {
        &arg0.sui_address_registry
    }

    public fun get_sui_address_registry_mut(arg0: &mut WalletState) : &mut 0x2::table::Table<address, bool> {
        &mut arg0.sui_address_registry
    }

    public fun get_used_nonces(arg0: &WalletState) : &0x2::table::Table<u64, bool> {
        &arg0.used_nonces
    }

    public fun get_used_nonces_mut(arg0: &mut WalletState) : &mut 0x2::table::Table<u64, bool> {
        &mut arg0.used_nonces
    }

    public fun get_user_wallets(arg0: &WalletState) : &0x2::table::Table<vector<u8>, WalletInfoV1> {
        &arg0.user_wallets
    }

    public fun get_user_wallets_mut(arg0: &mut WalletState) : &mut 0x2::table::Table<vector<u8>, WalletInfoV1> {
        &mut arg0.user_wallets
    }

    public fun get_version(arg0: &WalletState) : u64 {
        arg0.version
    }

    fun internal_create_wallet(arg0: &mut WalletState, arg1: vector<u8>, arg2: address, arg3: vector<u8>, arg4: &0x2::clock::Clock) {
        assert!(!0x2::table::contains<vector<u8>, WalletInfoV1>(&arg0.user_wallets, arg1), 101);
        assert!(!0x2::table::contains<address, bool>(&arg0.sui_address_registry, arg2), 102);
        let v0 = WalletInfoV1{
            user_id_onchain    : arg1,
            sui_address        : arg2,
            role               : arg3,
            creation_timestamp : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::table::add<vector<u8>, WalletInfoV1>(&mut arg0.user_wallets, arg1, v0);
        0x2::table::add<address, bool>(&mut arg0.sui_address_registry, arg2, true);
    }

    public fun new_wallet_admin_cap(arg0: &mut 0x2::tx_context::TxContext) : WalletAdminCap {
        WalletAdminCap{id: 0x2::object::new(arg0)}
    }

    public fun new_wallet_state(arg0: &mut 0x2::tx_context::TxContext) : WalletState {
        WalletState{
            id                   : 0x2::object::new(arg0),
            version              : 1,
            logic_id             : 0x2::object::id_from_address(@0x0),
            user_wallets         : 0x2::table::new<vector<u8>, WalletInfoV1>(arg0),
            sui_address_registry : 0x2::table::new<address, bool>(arg0),
            used_nonces          : 0x2::table::new<u64, bool>(arg0),
        }
    }

    public(friend) fun register_wallet(arg0: &WalletAdminCap, arg1: &mut WalletState, arg2: vector<u8>, arg3: address, arg4: vector<u8>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::table::contains<u64, bool>(&arg1.used_nonces, arg5), 103);
        0x2::table::add<u64, bool>(&mut arg1.used_nonces, arg5, true);
        internal_create_wallet(arg1, arg2, arg3, arg4, arg6);
    }

    public fun set_logic_id(arg0: &mut WalletState, arg1: 0x2::object::ID) {
        arg0.logic_id = arg1;
    }

    public fun set_version(arg0: &mut WalletState, arg1: u64) {
        arg0.version = arg1;
    }

    // decompiled from Move bytecode v6
}

