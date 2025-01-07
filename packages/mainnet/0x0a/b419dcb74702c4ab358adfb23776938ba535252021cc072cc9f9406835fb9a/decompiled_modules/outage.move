module 0xab419dcb74702c4ab358adfb23776938ba535252021cc072cc9f9406835fb9a::outage {
    struct OUTAGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: OUTAGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OUTAGE>(arg0, 6, b"Outage", b"Sui 1st Crash", b"Service Announcement: The Sui network is currently experiencing an outage and not processing transactions. Weve identified the issue and a fix will be deployed shortly. We appreciate your patience and will continue to provide updates.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/i_Shot_2024_11_21_20_13_04_39737f71d7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OUTAGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OUTAGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

