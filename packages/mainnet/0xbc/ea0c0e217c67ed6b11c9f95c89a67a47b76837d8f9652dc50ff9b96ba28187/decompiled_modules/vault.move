module 0xbcea0c0e217c67ed6b11c9f95c89a67a47b76837d8f9652dc50ff9b96ba28187::vault {
    struct Vault has key {
        id: 0x2::object::UID,
        coin: 0x2::coin::Coin<0x2::sui::SUI>,
    }

    public fun value(arg0: &Vault) : u64 {
        0x2::coin::value<0x2::sui::SUI>(&arg0.coin)
    }

    public entry fun unwrap_and_transfer(arg0: Vault, arg1: address) {
        let Vault {
            id   : v0,
            coin : v1,
        } = arg0;
        0x2::object::delete(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v1, arg1);
    }

    public entry fun wrap_and_transfer(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault{
            id   : 0x2::object::new(arg2),
            coin : arg0,
        };
        0x2::transfer::transfer<Vault>(v0, arg1);
    }

    // decompiled from Move bytecode v7
}

