module 0xbe760c50b92404b24ca33cd11ff5afc646018ccba8479eef608e256ba397025::bcr {
    struct BCR has drop {
        dummy_field: bool,
    }

    fun init(arg0: BCR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<BCR>(arg0, 6, b"BCR", b"Blockchain Runne by SuiAI", b"Running on Blockchain ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000019319_42c5438e5e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BCR>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BCR>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

