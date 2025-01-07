module 0x9dd366b412a384ff2f45671d19f29a8ed111d21eaeba8f576aa3898728eec03::cook {
    struct COOK has drop {
        dummy_field: bool,
    }

    fun init(arg0: COOK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COOK>(arg0, 6, b"COOK", b"COOK on Sui", x"4a757374206c65742068696d2024434f4f4b0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731525726963.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COOK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COOK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

