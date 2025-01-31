module 0x687701d312f61d1f65e611e6f900f385c8e634c5c577e4d1bed2149cf40f64a0::deep {
    struct DEEP has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEEP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEEP>(arg0, 6, b"Deep", b"Deepseek on Sui ", b"Deepseek on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1738297990951.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEEP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEEP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

