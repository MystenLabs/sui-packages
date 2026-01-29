module 0x441f1c4825d1ce900cb1139ebbacae0ac4297af509ff443b730f893ca3f8acc2::earth_mkzaz2me574m {
    struct EARTH_MKZAZ2ME574M has drop {
        dummy_field: bool,
    }

    fun init(arg0: EARTH_MKZAZ2ME574M, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EARTH_MKZAZ2ME574M>(arg0, 9, b"EARTH", b"Earth Coin", b"Make the World Grate again", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/QmNSo6uubxQhpmq8gj8zCTGuhYaq5ZfPThZRUmgTC41TMX")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EARTH_MKZAZ2ME574M>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EARTH_MKZAZ2ME574M>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

