module 0x53648b2a17bc489ada0154fdff370766fbbf1ebf5c5e3531b93a2dc7fe29d091::vault {
    struct Vault has store, key {
        id: 0x2::object::UID,
        coin: 0x2::coin::Coin<0x2::sui::SUI>,
    }

    public entry fun unwrap_coin(arg0: Vault, arg1: &mut 0x2::tx_context::TxContext) {
        let Vault {
            id   : v0,
            coin : v1,
        } = arg0;
        0x2::object::delete(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun unwrap_to(arg0: Vault, arg1: address) {
        let Vault {
            id   : v0,
            coin : v1,
        } = arg0;
        0x2::object::delete(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v1, arg1);
    }

    public entry fun wrap_coin(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault{
            id   : 0x2::object::new(arg1),
            coin : arg0,
        };
        0x2::transfer::public_transfer<Vault>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

