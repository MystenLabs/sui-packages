module 0xb6948b9c55c6172b5ddb68adaefe7de46936aeaf728c242a331a5be4180f5478::greenpump {
    struct GREENPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: GREENPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GREENPUMP>(arg0, 6, b"GREENPUMP", b"GREEN PUMP", b"Everything is Green in SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/green2_c70a7946ff.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GREENPUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GREENPUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

