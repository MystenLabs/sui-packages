module 0x418c1edd99fe4bed63f0f77e8c336096d326033890c92913aa6f531ffed0da3::whiz {
    struct WHIZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHIZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHIZ>(arg0, 6, b"WHIZ", b"The Whiz", b"Summoning pure degen energy on SUi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3324_cc3dc7f2cc.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHIZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WHIZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

