module 0x7aa7208efc1b2a285d025ac0277449e546b0bdd19d260564a8419aa1aa9a11c8::heheh {
    struct HEHEH has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEHEH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEHEH>(arg0, 6, b"Heheh", b"Grhehh", b"Ghh", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/A18403_E3_B57_E_40_F1_BFE_4_8_F051_E780522_c7ad025eed.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HEHEH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HEHEH>>(v1);
    }

    // decompiled from Move bytecode v6
}

