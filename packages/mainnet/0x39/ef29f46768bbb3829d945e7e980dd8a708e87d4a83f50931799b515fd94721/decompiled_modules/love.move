module 0x39ef29f46768bbb3829d945e7e980dd8a708e87d4a83f50931799b515fd94721::love {
    struct LOVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOVE>(arg0, 9, b"love", b"love", b"preacher on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LOVE>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOVE>>(v2, @0x23ddfad1bd606b4c3129fadea8b06e90fde9ee1b1290154dcbb3e4ed49f35c6f);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

