module 0xce52e77b8c68c135aaec9ed827b5492047b9e3e1d603d15ec5b06e3a9c150de1::caftel {
    struct CAFTEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAFTEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAFTEL>(arg0, 6, b"CAFTEL", b"Cat In Black", x"2443414654454c206973206120465249454e444c592063617473206f6e2074686520535549206e6574776f726b2e0a4d65654f4f4f4f212121", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiexv334x6mhretubnz5fxheyjbmyew7cv7vga5j5k7nixgnigdzma")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAFTEL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CAFTEL>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

