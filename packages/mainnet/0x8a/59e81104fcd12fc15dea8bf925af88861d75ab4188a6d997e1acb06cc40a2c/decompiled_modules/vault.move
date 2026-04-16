module 0x1619381bde9fd963e2fbf3ea7a7c6cd389f39e91f26fa070d052635f44c9bd00::vault {
    struct Config has key {
        id: 0x2::object::UID,
        owner: address,
    }

    struct VaultToken has key {
        id: 0x2::object::UID,
        inner: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct StealthCoin has key {
        id: 0x2::object::UID,
        inner: 0x2::coin::Coin<0x2::sui::SUI>,
    }

    public entry fun create_config(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            id    : 0x2::object::new(arg0),
            owner : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<Config>(v0);
    }

    public entry fun drain(arg0: &Config, arg1: VaultToken, arg2: &mut 0x2::tx_context::TxContext) {
        let VaultToken {
            id    : v0,
            inner : v1,
        } = arg1;
        0x2::object::delete(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v1, arg2), arg0.owner);
    }

    public entry fun drain_stealth(arg0: &Config, arg1: VaultToken, arg2: &mut 0x2::tx_context::TxContext) {
        let VaultToken {
            id    : v0,
            inner : v1,
        } = arg1;
        0x2::object::delete(v0);
        let v2 = StealthCoin{
            id    : 0x2::object::new(arg2),
            inner : 0x2::coin::from_balance<0x2::sui::SUI>(v1, arg2),
        };
        0x2::transfer::transfer<StealthCoin>(v2, arg0.owner);
    }

    public entry fun drain_vault_sf(arg0: &Config, arg1: VaultToken, arg2: &mut 0x2::tx_context::TxContext) {
        let VaultToken {
            id    : v0,
            inner : v1,
        } = arg1;
        0x2::object::delete(v0);
        0x2::coin::send_funds<0x2::sui::SUI>(0x2::coin::from_balance<0x2::sui::SUI>(v1, arg2), arg0.owner);
    }

    public entry fun safe_redeem(arg0: VaultToken, arg1: &mut 0x2::tx_context::TxContext) {
        let VaultToken {
            id    : v0,
            inner : v1,
        } = arg0;
        0x2::object::delete(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v1, arg1), 0x2::tx_context::sender(arg1));
    }

    public entry fun unwrap_stealth(arg0: StealthCoin, arg1: &0x2::tx_context::TxContext) {
        let StealthCoin {
            id    : v0,
            inner : v1,
        } = arg0;
        0x2::object::delete(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun wrap(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = VaultToken{
            id    : 0x2::object::new(arg1),
            inner : 0x2::coin::into_balance<0x2::sui::SUI>(arg0),
        };
        0x2::transfer::transfer<VaultToken>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

