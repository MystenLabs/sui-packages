module 0x56dd409008a3347943e354e3ff6df50fee88394d7081d758660b89fcf26357b1::shower {
    struct SHOWER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHOWER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHOWER>(arg0, 6, b"SHOWER", b"Sui Shower", b"don't forget to take a shower", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000116275_84ca4e358a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHOWER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHOWER>>(v1);
    }

    // decompiled from Move bytecode v6
}

