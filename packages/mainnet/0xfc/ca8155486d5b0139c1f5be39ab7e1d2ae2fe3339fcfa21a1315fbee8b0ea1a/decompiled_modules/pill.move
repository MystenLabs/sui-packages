module 0xfcca8155486d5b0139c1f5be39ab7e1d2ae2fe3339fcfa21a1315fbee8b0ea1a::pill {
    struct PILL has drop {
        dummy_field: bool,
    }

    fun init(arg0: PILL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PILL>(arg0, 6, b"PILL", b"Pill", b"You take the blue pill, the story ends. You wake up in your bed and believe whatever you want to believe. You take the Movepump pill, you stay in Wonderland. And I show you how deep the rabbit hole goes.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_12_31_13_02_31_8fc1bdfb5f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PILL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PILL>>(v1);
    }

    // decompiled from Move bytecode v6
}

