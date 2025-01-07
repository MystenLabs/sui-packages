module 0xca17f31b1ff146aa1c0b181ecd69e00f2216c79e1fa7e96c35774533861b0dfa::bluefin_vault {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct VaultOwnerCap has key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
    }

    struct CreateVaultCap<phantom T0> has key {
        id: 0x2::object::UID,
        lp_treasury_cap: 0x2::coin::TreasuryCap<T0>,
        lp_coin_metadata: 0x2::coin::CoinMetadata<T0>,
    }

    public fun create_vault_cap<T0: drop>(arg0: &AdminCap, arg1: T0, arg2: u8, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: 0x1::option::Option<0x2::url::Url>, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<T0>(arg1, arg2, arg5, arg3, arg4, arg6, arg7);
        let v2 = CreateVaultCap<T0>{
            id               : 0x2::object::new(arg7),
            lp_treasury_cap  : v0,
            lp_coin_metadata : v1,
        };
        0x2::transfer::transfer<CreateVaultCap<T0>>(v2, 0x2::tx_context::sender(arg7));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

