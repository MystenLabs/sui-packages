module 0x302900fccd2e0dac3c55b1c4a38446557703c4c5223f8de02876e4e19e003dee::suimonk {
    struct SUIMONK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMONK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMONK>(arg0, 6, b"SUIMONK", b"MONK FISH", b"LORD FISH ON SUI $SUIMONK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3661_79afded461.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMONK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMONK>>(v1);
    }

    // decompiled from Move bytecode v6
}

