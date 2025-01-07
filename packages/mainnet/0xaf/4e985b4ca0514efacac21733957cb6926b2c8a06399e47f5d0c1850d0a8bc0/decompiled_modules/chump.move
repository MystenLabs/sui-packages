module 0xaf4e985b4ca0514efacac21733957cb6926b2c8a06399e47f5d0c1850d0a8bc0::chump {
    struct CHUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHUMP>(arg0, 6, b"CHUMP", b"Donald J CHUMP", b"DJChumps all about chill vibes and tight bonds. Its not just coin talk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/fatcatsquarenobg_1024x744_f2d6b08ce8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

