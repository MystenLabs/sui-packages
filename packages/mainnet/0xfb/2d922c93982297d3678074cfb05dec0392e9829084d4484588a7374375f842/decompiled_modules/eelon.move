module 0xfb2d922c93982297d3678074cfb05dec0392e9829084d4484588a7374375f842::eelon {
    struct EELON has drop {
        dummy_field: bool,
    }

    fun init(arg0: EELON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EELON>(arg0, 6, b"EELON", b"EELON SUI", b"The most electric memecoin on SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/EELON_765d48b8a2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EELON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EELON>>(v1);
    }

    // decompiled from Move bytecode v6
}

