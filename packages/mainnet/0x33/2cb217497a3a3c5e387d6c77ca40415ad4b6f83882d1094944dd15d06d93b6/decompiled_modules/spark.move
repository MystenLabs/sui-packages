module 0x332cb217497a3a3c5e387d6c77ca40415ad4b6f83882d1094944dd15d06d93b6::spark {
    struct SPARK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPARK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPARK>(arg0, 6, b"SPARK", b"Spark AI", b"The first all in One AI Agent & Insured Financial Advisor.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734743056116.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPARK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPARK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

