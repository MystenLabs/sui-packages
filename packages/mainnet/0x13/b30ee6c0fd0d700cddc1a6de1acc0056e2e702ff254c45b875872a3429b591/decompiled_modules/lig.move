module 0x13b30ee6c0fd0d700cddc1a6de1acc0056e2e702ff254c45b875872a3429b591::lig {
    struct LIG has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIG>(arg0, 6, b"LIG", b"LIGROG", b"LIGROG is the answer for those who are tired of stressful investments", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1755429578020.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LIG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

