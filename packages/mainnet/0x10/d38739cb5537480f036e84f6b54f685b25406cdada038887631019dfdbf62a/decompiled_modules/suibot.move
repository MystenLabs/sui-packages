module 0x10d38739cb5537480f036e84f6b54f685b25406cdada038887631019dfdbf62a::suibot {
    struct SUIBOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBOT>(arg0, 6, b"SuiBot", b"sui sbot", b"Sui network sniper bot", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000002174_63f1328aea.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

