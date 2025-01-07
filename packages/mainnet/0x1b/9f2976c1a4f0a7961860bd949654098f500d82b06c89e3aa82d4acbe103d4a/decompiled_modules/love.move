module 0x1b9f2976c1a4f0a7961860bd949654098f500d82b06c89e3aa82d4acbe103d4a::love {
    struct LOVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOVE>(arg0, 9, b"LOVE", b"Love", b"Feel the Love", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.dribbble.com/userupload/16991279/file/original-ba276a0630d52b5d2c02416e082b5b08.jpg?resize=1024x768")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LOVE>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOVE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

