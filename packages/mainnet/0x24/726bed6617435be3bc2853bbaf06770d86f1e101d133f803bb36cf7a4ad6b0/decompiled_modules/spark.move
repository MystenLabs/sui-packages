module 0x24726bed6617435be3bc2853bbaf06770d86f1e101d133f803bb36cf7a4ad6b0::spark {
    struct SPARK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPARK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPARK>(arg0, 6, b"SPARK", b"Spark AI", b"The first all in One AI Agent & Insured Financial Advisor.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/q3_D3rqc_D_400x400_60e1636392.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPARK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPARK>>(v1);
    }

    // decompiled from Move bytecode v6
}

