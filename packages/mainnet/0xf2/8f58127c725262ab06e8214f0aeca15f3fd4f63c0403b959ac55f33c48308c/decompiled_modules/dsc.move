module 0xf28f58127c725262ab06e8214f0aeca15f3fd4f63c0403b959ac55f33c48308c::dsc {
    struct DSC has drop {
        dummy_field: bool,
    }

    fun init(arg0: DSC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DSC>(arg0, 6, b"DSC", b"DSCTATTOO", x"e2809c494d41474553204f4620504552534f4e414c20534154495346414354494f4e2c20414e4420524553554c5453204f4620574f524b20494e2046554c4c204f5045524154494f4ee2809d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1733366262478.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DSC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DSC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

