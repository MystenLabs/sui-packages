module 0x9926751e0d2e856b494cf10b6ccf95547fc2090c91ccee0ed1f5aca3469ba299::IMG {
    struct IMG has drop {
        dummy_field: bool,
    }

    fun init(arg0: IMG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = mint(arg0, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<IMG>>(v0);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<IMG>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: IMG, arg1: &mut 0x2::tx_context::TxContext) : (0x2::coin::TreasuryCap<IMG>, 0x2::coin::CoinMetadata<IMG>) {
        let (v0, v1) = 0x2::coin::create_currency<IMG>(arg0, 9, b"TKN", b"Token", b"A token with an image", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://s3-media0.fl.yelpcdn.com/bphoto/m7RI8nb2ONOgWyFTLaBTBA/o.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<IMG>(&mut v2, 1000000000000000000, @0x5fd1795d672251a1e8889f2646393b3516097dc1adb20d906a25ff4ede372ed3, arg1);
        (v2, v1)
    }

    // decompiled from Move bytecode v6
}

