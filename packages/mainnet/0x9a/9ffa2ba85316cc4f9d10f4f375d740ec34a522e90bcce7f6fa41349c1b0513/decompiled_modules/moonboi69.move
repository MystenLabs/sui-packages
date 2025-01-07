module 0x9a9ffa2ba85316cc4f9d10f4f375d740ec34a522e90bcce7f6fa41349c1b0513::moonboi69 {
    struct MOONBOI69 has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOONBOI69, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOONBOI69>(arg0, 6, b"Moonboi69", b"MOONBOI69", x"4d4f4f564520414c4f4e47204d4f4f4e424f4920574520444f4f4d4544204c45545320414c4c2053454c4c204154205448452053414d452054494d4520495453204f5645522057452041524520534f204241434b0a0a502e532e20244d4f4f4e424f49363920484f4c44455253204541545320434f524e20544845204c4f4e4720574159", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731069728275.gif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOONBOI69>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOONBOI69>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

