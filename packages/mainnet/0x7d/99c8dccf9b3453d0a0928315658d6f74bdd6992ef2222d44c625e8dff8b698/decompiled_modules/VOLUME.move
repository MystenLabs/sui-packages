module 0x7d99c8dccf9b3453d0a0928315658d6f74bdd6992ef2222d44c625e8dff8b698::VOLUME {
    struct VOLUME has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<VOLUME>, arg1: 0x2::coin::Coin<VOLUME>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<VOLUME>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<VOLUME>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<VOLUME>>(0x2::coin::mint<VOLUME>(arg0, arg1, arg3), arg2);
    }

    public entry fun freeze_treasury_cap(arg0: 0x2::coin::TreasuryCap<VOLUME>) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<VOLUME>>(arg0);
    }

    fun init(arg0: VOLUME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VOLUME>(arg0, 9, b"VOLUME", b"MARSHAL", b"Listen", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.ebest.cl/media/catalog/product/cache/47abc4af9d81a631bd44d97ba9797770/p/a/parlante-marshall-acton-blanco-1.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VOLUME>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VOLUME>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

