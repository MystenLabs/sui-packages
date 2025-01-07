module 0xb95f3e2596eb91e680a6ddc9740d3a9caccc846177248423331fb135aa3096bb::toa {
    struct TOA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOA>(arg0, 6, b"TOA", b"Tariff on Aliens", b"Tariff on Aliens its a cryptocurrency meme likely depicts a humorous scenario where an extraterrestrial visitors are subject to earthly tariffs..", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/EFA_8_F22_C_D854_41_B6_A5_F1_254_B09_E7_FED_8_085ea2b952.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOA>>(v1);
    }

    // decompiled from Move bytecode v6
}

