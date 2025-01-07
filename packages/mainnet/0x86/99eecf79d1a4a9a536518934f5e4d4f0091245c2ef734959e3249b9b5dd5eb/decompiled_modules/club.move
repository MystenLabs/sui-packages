module 0x8699eecf79d1a4a9a536518934f5e4d4f0091245c2ef734959e3249b9b5dd5eb::club {
    struct CLUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLUB>(arg0, 6, b"CLUB", b"27 Club", b"Tribute coin to the legendary 27 club and all the legendary artists who left us to soon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000031562_771a4b9f82.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLUB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CLUB>>(v1);
    }

    // decompiled from Move bytecode v6
}

