module 0x9c20649d039cc612b7b6c639c1ce3ab8542469c2e8a592fab3d1fc75af0ee8e9::sutardio {
    struct SUTARDIO has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUTARDIO>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SUTARDIO>>(0x2::coin::mint<SUTARDIO>(arg0, arg2 * 1000000000, arg3), arg1);
    }

    fun init(arg0: SUTARDIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUTARDIO>(arg0, 9, b"SUTARD", b"SUTARDIO", b"We are all just SUTARDS looking for the big break.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUTARDIO>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUTARDIO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUTARDIO>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

