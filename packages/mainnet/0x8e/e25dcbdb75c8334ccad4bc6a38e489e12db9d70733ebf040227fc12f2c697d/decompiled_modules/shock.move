module 0x8ee25dcbdb75c8334ccad4bc6a38e489e12db9d70733ebf040227fc12f2c697d::shock {
    struct SHOCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHOCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHOCK>(arg0, 6, b"SHOCK", b"Shocked Seal", b"Woah! Didn't see you there!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/shockedd_28c1dcf3c6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHOCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHOCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

