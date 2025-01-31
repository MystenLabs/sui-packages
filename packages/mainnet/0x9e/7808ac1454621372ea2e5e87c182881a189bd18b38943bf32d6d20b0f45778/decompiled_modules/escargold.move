module 0x9e7808ac1454621372ea2e5e87c182881a189bd18b38943bf32d6d20b0f45778::escargold {
    struct ESCARGOLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: ESCARGOLD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ESCARGOLD>(arg0, 6, b"ESCARGOLD", b"EscarGold", b"EscarGold Memes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000031888_e6f572b140.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ESCARGOLD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ESCARGOLD>>(v1);
    }

    // decompiled from Move bytecode v6
}

