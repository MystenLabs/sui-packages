module 0xf7d2eccb2447a3fe8a54611600d6567a6f64d2500cb7b679dd0704d72eb0af1a::eater {
    struct EATER has drop {
        dummy_field: bool,
    }

    fun init(arg0: EATER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EATER>(arg0, 6, b"Eater", b"Sui Eater", b"I'll talk her soul and spit it out on the Dex for you CHAD'S ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000012292_d43bbaa83b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EATER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EATER>>(v1);
    }

    // decompiled from Move bytecode v6
}

