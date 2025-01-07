module 0x3400aa2e9e87937086012303809a3a527bbd8e7037913ca47ec5cebadd5204d3::sroot {
    struct SROOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SROOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SROOT>(arg0, 6, b"SROOT", b"I AM SROOT", b"$SROOT is a new generation of meme token with powerful utility: a seamless bridge to SUI, making it easier than ever to transfer tokens across different chains. Join the community triggering explosive growth of the entire SUI universe.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1734993828_0326052_BF_0_C6937_CE_09_40_A8_9_E19_686_AE_03968_EB_3f6174fcb0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SROOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SROOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

