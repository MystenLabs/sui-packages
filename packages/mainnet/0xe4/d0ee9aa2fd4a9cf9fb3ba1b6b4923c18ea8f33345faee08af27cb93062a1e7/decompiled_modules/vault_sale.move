module 0xe4d0ee9aa2fd4a9cf9fb3ba1b6b4923c18ea8f33345faee08af27cb93062a1e7::vault_sale {
    struct VaultSale<T0: drop + store> has store, key {
        id: 0x2::object::UID,
        price_per_token: u64,
        lot_size: u64,
        beneficiary: address,
        vault: 0x2::coin::Coin<T0>,
    }

    public entry fun buy_exact<T0: drop + store>(arg0: &mut VaultSale<T0>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 >= arg0.lot_size, 0);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) == arg0.price_per_token * arg2, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, arg0.beneficiary);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0.vault, arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun create<T0: drop + store>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = VaultSale<T0>{
            id              : 0x2::object::new(arg4),
            price_per_token : arg1,
            lot_size        : arg2,
            beneficiary     : arg3,
            vault           : arg0,
        };
        0x2::transfer::public_transfer<VaultSale<T0>>(v0, 0x2::tx_context::sender(arg4));
    }

    public entry fun deposit<T0: drop + store>(arg0: &mut VaultSale<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::coin::join<T0>(&mut arg0.vault, arg1);
    }

    public entry fun set_beneficiary<T0: drop + store>(arg0: &mut VaultSale<T0>, arg1: address) {
        arg0.beneficiary = arg1;
    }

    public entry fun set_lot<T0: drop + store>(arg0: &mut VaultSale<T0>, arg1: u64) {
        arg0.lot_size = arg1;
    }

    public entry fun set_price<T0: drop + store>(arg0: &mut VaultSale<T0>, arg1: u64) {
        arg0.price_per_token = arg1;
    }

    public entry fun withdraw<T0: drop + store>(arg0: &mut VaultSale<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0.vault, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

