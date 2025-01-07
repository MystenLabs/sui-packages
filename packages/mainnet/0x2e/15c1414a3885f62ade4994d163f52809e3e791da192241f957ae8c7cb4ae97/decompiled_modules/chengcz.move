module 0x2e15c1414a3885f62ade4994d163f52809e3e791da192241f957ae8c7cb4ae97::chengcz {
    struct CHENGCZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHENGCZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHENGCZ>(arg0, 6, b"ChengCZ", b"CZONSUI", b"WE love cz and meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_530e8d5cb0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHENGCZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHENGCZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

