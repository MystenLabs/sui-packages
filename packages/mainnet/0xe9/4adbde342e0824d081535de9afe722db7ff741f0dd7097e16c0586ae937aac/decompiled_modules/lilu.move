module 0xe94adbde342e0824d081535de9afe722db7ff741f0dd7097e16c0586ae937aac::lilu {
    struct LILU has drop {
        dummy_field: bool,
    }

    fun init(arg0: LILU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LILU>(arg0, 6, b"LILU", b"LILU", b"New GEM launch!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://media1.tenor.com/m/cGtE55NwCqQAAAAC/come-on.gif")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LILU>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LILU>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LILU>>(v1);
    }

    // decompiled from Move bytecode v6
}

