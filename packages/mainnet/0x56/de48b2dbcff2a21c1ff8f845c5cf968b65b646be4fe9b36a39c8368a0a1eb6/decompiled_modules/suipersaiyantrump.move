module 0x56de48b2dbcff2a21c1ff8f845c5cf968b65b646be4fe9b36a39c8368a0a1eb6::suipersaiyantrump {
    struct SUIPERSAIYANTRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPERSAIYANTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPERSAIYANTRUMP>(arg0, 6, b"SuiperSaiyanTrump", b"Suiper Suiyan Trump", b"First Suiper Saiyan Trump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_8c182ab770.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPERSAIYANTRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPERSAIYANTRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

