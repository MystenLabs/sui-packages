module 0xaa5845b48efd2209d6087c75a31d9982e1070823aff8f8eb00c67c6c4063a0db::shareio {
    struct SHAREIO has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<SHAREIO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SHAREIO>>(0x2::coin::mint<SHAREIO>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: SHAREIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHAREIO>(arg0, 9, b"Shareio", b"SHAREIO", b"A stable coin issued by Circle", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://test.shareio.com/images/shareio-token-logo.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHAREIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHAREIO>>(v1);
    }

    // decompiled from Move bytecode v6
}

