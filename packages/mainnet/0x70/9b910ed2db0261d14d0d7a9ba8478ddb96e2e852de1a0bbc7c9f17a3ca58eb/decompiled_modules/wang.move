module 0x709b910ed2db0261d14d0d7a9ba8478ddb96e2e852de1a0bbc7c9f17a3ca58eb::wang {
    struct WANG has drop {
        dummy_field: bool,
    }

    fun init(arg0: WANG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WANG>(arg0, 6, b"WANG", b"WangCaiCat", b"WangCaiCat () knows that is only possible to achieve prosperity through hard work and consistency.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_10_02_03_08_70fe26c084.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WANG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WANG>>(v1);
    }

    // decompiled from Move bytecode v6
}

