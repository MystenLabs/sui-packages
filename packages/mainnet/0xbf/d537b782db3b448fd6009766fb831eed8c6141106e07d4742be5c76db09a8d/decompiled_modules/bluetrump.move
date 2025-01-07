module 0xbfd537b782db3b448fd6009766fb831eed8c6141106e07d4742be5c76db09a8d::bluetrump {
    struct BLUETRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUETRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUETRUMP>(arg0, 6, b"BlueTrump", b"Blue Trump", b"Blue Trump ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000003288_81732a7f1e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUETRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUETRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

