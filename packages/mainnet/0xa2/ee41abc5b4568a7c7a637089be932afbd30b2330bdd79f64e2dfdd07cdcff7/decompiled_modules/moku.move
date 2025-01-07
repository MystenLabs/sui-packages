module 0xa2ee41abc5b4568a7c7a637089be932afbd30b2330bdd79f64e2dfdd07cdcff7::moku {
    struct MOKU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOKU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOKU>(arg0, 6, b"MOKU", b"Moku", b"Game Publisher   Play, share & get rewarded", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a27a8f346394aec2e13e90b1289ba0_61701074fa.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOKU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOKU>>(v1);
    }

    // decompiled from Move bytecode v6
}

