module 0x268d479f5f7cac609f1cdf2aca4a4d12f1442827d91d0fa588479438239bc9bc::oatmeal {
    struct OATMEAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: OATMEAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OATMEAL>(arg0, 6, b"OATMEAL", b"ORIGINAL POPCAT", b"ORIGINAL POPCAT $OATMEAL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/qf_Zt_Vquq_400x400_f38bd0fd9c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OATMEAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OATMEAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

