module 0x57ce23eae803380111babec7e2527a193fd0d864ce7e77762fa921e19dcb49ac::gidi {
    struct GIDI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GIDI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GIDI>(arg0, 6, b"GIDI", b"Sui Gidi", b"Gidi finally landed on SUI and is ready to have a chit chat with you", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_2024_09_16_T201428_175_254ecb7c23.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GIDI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GIDI>>(v1);
    }

    // decompiled from Move bytecode v6
}

