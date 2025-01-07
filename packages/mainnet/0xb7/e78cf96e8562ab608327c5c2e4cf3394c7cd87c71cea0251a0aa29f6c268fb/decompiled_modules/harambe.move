module 0xb7e78cf96e8562ab608327c5c2e4cf3394c7cd87c71cea0251a0aa29f6c268fb::harambe {
    struct HARAMBE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HARAMBE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HARAMBE>(arg0, 6, b"HARAMBE", b"Haraambe", b"Harambe on Sui pays homage to the legendary silverback gorilla whose spirit captivated the world. May he rest in peace, beating his chest in heaven.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2024_10_12_14_46_25_4dfcb337f4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HARAMBE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HARAMBE>>(v1);
    }

    // decompiled from Move bytecode v6
}

