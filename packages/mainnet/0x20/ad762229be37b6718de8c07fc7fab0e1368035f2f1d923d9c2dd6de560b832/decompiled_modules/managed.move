module 0x20ad762229be37b6718de8c07fc7fab0e1368035f2f1d923d9c2dd6de560b832::managed {
    struct MANAGED has drop {
        dummy_field: bool,
    }

    struct ManagedAdmin has store, key {
        id: 0x2::object::UID,
        data: u64,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MANAGED>, arg1: 0x2::coin::Coin<MANAGED>) {
        0x2::coin::burn<MANAGED>(arg0, arg1);
    }

    fun init(arg0: MANAGED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MANAGED>(arg0, 2, b"MANAGED", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MANAGED>>(v1);
        let v2 = ManagedAdmin{
            id   : 0x2::object::new(arg1),
            data : 1,
        };
        0x2::transfer::public_transfer<ManagedAdmin>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MANAGED>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MANAGED>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MANAGED>(arg0, arg1, arg2, arg3);
    }

    public entry fun owner_func(arg0: &ManagedAdmin) {
    }

    public entry fun owner_func_mut(arg0: &mut ManagedAdmin) {
        arg0.data = arg0.data + 1;
    }

    // decompiled from Move bytecode v6
}

