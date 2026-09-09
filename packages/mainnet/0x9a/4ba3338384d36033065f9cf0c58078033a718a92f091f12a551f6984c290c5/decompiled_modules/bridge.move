module 0x9a4ba3338384d36033065f9cf0c58078033a718a92f091f12a551f6984c290c5::bridge {
    struct BridgeVault<phantom T0> has key {
        id: 0x2::object::UID,
        treasury: 0x2::coin::TreasuryCap<T0>,
        ticker: vector<u8>,
        minted: 0x2::table::Table<vector<u8>, bool>,
    }

    struct MinterCap has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
    }

    struct MintedEvent has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        ticker: vector<u8>,
        amount: u64,
        recipient: address,
        rh_ref: vector<u8>,
    }

    struct RedeemBurned has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        ticker: vector<u8>,
        amount: u64,
        burner: address,
        rh_dest: vector<u8>,
    }

    public fun burn<T0>(arg0: &mut BridgeVault<T0>, arg1: 0x2::coin::Coin<T0>, arg2: vector<u8>, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 2);
        assert!(0x1::vector::length<u8>(&arg2) == 20, 5);
        0x2::coin::burn<T0>(&mut arg0.treasury, arg1);
        let v1 = RedeemBurned{
            coin_type : 0x1::type_name::with_defining_ids<T0>(),
            ticker    : arg0.ticker,
            amount    : v0,
            burner    : 0x2::tx_context::sender(arg3),
            rh_dest   : arg2,
        };
        0x2::event::emit<RedeemBurned>(v1);
    }

    public fun mint<T0>(arg0: &mut BridgeVault<T0>, arg1: &MinterCap, arg2: u64, arg3: address, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.vault_id == 0x2::object::id<BridgeVault<T0>>(arg0), 1);
        assert!(arg2 > 0, 2);
        assert!(!0x1::vector::is_empty<u8>(&arg4), 4);
        assert!(!0x2::table::contains<vector<u8>, bool>(&arg0.minted, arg4), 3);
        0x2::table::add<vector<u8>, bool>(&mut arg0.minted, arg4, true);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::mint<T0>(&mut arg0.treasury, arg2, arg5), arg3);
        let v0 = MintedEvent{
            coin_type : 0x1::type_name::with_defining_ids<T0>(),
            ticker    : arg0.ticker,
            amount    : arg2,
            recipient : arg3,
            rh_ref    : arg4,
        };
        0x2::event::emit<MintedEvent>(v0);
    }

    public fun total_supply<T0>(arg0: &BridgeVault<T0>) : u64 {
        0x2::coin::total_supply<T0>(&arg0.treasury)
    }

    public fun create_vault<T0>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) : (BridgeVault<T0>, MinterCap) {
        let v0 = BridgeVault<T0>{
            id       : 0x2::object::new(arg2),
            treasury : arg0,
            ticker   : arg1,
            minted   : 0x2::table::new<vector<u8>, bool>(arg2),
        };
        let v1 = MinterCap{
            id       : 0x2::object::new(arg2),
            vault_id : 0x2::object::id<BridgeVault<T0>>(&v0),
        };
        (v0, v1)
    }

    public fun is_minted<T0>(arg0: &BridgeVault<T0>, arg1: vector<u8>) : bool {
        0x2::table::contains<vector<u8>, bool>(&arg0.minted, arg1)
    }

    public fun share_vault<T0>(arg0: BridgeVault<T0>) {
        0x2::transfer::share_object<BridgeVault<T0>>(arg0);
    }

    public fun ticker<T0>(arg0: &BridgeVault<T0>) : vector<u8> {
        arg0.ticker
    }

    public fun vault_id<T0>(arg0: &BridgeVault<T0>) : 0x2::object::ID {
        0x2::object::id<BridgeVault<T0>>(arg0)
    }

    public fun vault_id_of_minter(arg0: &MinterCap) : 0x2::object::ID {
        arg0.vault_id
    }

    // decompiled from Move bytecode v7
}

