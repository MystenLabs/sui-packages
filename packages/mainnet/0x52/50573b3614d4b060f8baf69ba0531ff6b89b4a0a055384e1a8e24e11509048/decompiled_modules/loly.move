module 0x5250573b3614d4b060f8baf69ba0531ff6b89b4a0a055384e1a8e24e11509048::loly {
    struct LOLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOLY>(arg0, 6, b"LOLY", b"Loly Pinky Sui", b"$Loly an adorable and cute white dog with pink nuances, relies on her intelligence and ingenuity to get ready to sail the ocean on the Sui network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000001710_f02b757b73.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

