module 0xe657c14b5358b5c9fa77950a6695d059c3a356e3f582fd88219eec3ed414d921::issa {
    struct ISSA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ISSA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ISSA>(arg0, 9, b"ISSA", b"Issa Token", b"A token for the SUI ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ISSA>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ISSA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ISSA>>(v1);
    }

    // decompiled from Move bytecode v6
}

