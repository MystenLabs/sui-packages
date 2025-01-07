module 0xbddce55b85aecfe5b36071667125c5e674e699eeaa8c44ff4717bc71034a1507::ej {
    struct EJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: EJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EJ>(arg0, 5, b"EJ", b"EJ", b"Just a Pug", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ibb.co/xMSZsXf")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<EJ>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EJ>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

