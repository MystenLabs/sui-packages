module 0x6f56f66afa33a1554042726374c31784191bf19b033fb7ebb64263e6d0ddef54::scuba {
    struct SCUBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCUBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCUBA>(arg0, 6, b"SCUBA", b"SCUBA Dog", x"5468652063757465737420736375626120646976696e6720706f6f636820686173206c616e646564206f6e2053756921200a0a54656c656772616d3a2068747470733a2f2f742e6d652f5363756261537569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/zcb24_PCH_400x400_b41ae53edd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCUBA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCUBA>>(v1);
    }

    // decompiled from Move bytecode v6
}

