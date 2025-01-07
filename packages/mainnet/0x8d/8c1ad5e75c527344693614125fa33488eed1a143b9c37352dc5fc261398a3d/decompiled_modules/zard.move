module 0x8d8c1ad5e75c527344693614125fa33488eed1a143b9c37352dc5fc261398a3d::zard {
    struct ZARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZARD>(arg0, 6, b"Zard", b"SuiZard", b"Meet Suizard, the blue crypto champion here to revolutionize the blockchain world with unmatched innovation!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000014049_6cdc179ecd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZARD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZARD>>(v1);
    }

    // decompiled from Move bytecode v6
}

