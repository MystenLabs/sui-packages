module 0x96fbba694ccf54f16d5e465216389520ddd3b322f48acc7c8fa72797340e4c95::suioutage {
    struct SUIOUTAGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIOUTAGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIOUTAGE>(arg0, 6, b"SuiOutage", b"SuiCrash1st", b"Service Announcement: The Sui network is currently experiencing an outage and not processing transactions. Weve identified the issue and a fix will be deployed shortly. We appreciate your patience and will continue to provide updates.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/i_Shot_2024_11_21_20_13_04_17d5846a31.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIOUTAGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIOUTAGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

