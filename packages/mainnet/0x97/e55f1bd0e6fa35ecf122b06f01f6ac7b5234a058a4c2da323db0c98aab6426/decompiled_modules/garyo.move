module 0x97e55f1bd0e6fa35ecf122b06f01f6ac7b5234a058a4c2da323db0c98aab6426::garyo {
    struct GARYO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GARYO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GARYO>(arg0, 6, b"GARYO", b"GARY0.00", b"$GARY0.00 The Government A$$ that Recks your YOLO opportunities! He wants all of your wallets to go to 0.00! Join the anti-gov movement with your middle finger!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3809_d66e248f00.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GARYO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GARYO>>(v1);
    }

    // decompiled from Move bytecode v6
}

