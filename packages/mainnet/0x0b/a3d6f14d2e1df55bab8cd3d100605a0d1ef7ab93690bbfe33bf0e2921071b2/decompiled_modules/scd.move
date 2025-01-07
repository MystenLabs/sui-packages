module 0xba3d6f14d2e1df55bab8cd3d100605a0d1ef7ab93690bbfe33bf0e2921071b2::scd {
    struct SCD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCD>(arg0, 6, b"SCD", b"SUICIDE4", b"Suicide Squad be save Blockchain World", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/f3d3f142_ca5e_46b7_8e01_a7e6c6cacf21_5c602754ca.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCD>>(v1);
    }

    // decompiled from Move bytecode v6
}

