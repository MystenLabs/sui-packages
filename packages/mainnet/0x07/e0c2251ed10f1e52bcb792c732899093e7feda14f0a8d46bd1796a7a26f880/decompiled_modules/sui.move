module 0x7e0c2251ed10f1e52bcb792c732899093e7feda14f0a8d46bd1796a7a26f880::sui {
    struct SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI>(arg0, 6, b"SUI", b"SUI (memecoin version)", b"Pump $SUI and hold. SUI/SUI is an insane ticker. Dev will pay dex and HODL till 10 million. Just for fun. DYOR. ONLY INVEST ON WHAT YOU CAN LOSE. DO NOT FALL FOR FOMO. HOLDING long term is more profitable. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUI_26246130f5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

