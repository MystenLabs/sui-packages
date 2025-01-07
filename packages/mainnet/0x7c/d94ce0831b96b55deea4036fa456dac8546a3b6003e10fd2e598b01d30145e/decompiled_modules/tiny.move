module 0x7cd94ce0831b96b55deea4036fa456dac8546a3b6003e10fd2e598b01d30145e::tiny {
    struct TINY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TINY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TINY>(arg0, 6, b"TINY", b"TINY TITAN", b"TINY TITAN SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3619_67770242f0.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TINY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TINY>>(v1);
    }

    // decompiled from Move bytecode v6
}

