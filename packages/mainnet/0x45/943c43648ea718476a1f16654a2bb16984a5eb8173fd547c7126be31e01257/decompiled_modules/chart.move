module 0x45943c43648ea718476a1f16654a2bb16984a5eb8173fd547c7126be31e01257::chart {
    struct CHART has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHART, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHART>(arg0, 6, b"Chart", b"Chicken Art", x"636869636173736f27732066696e65737420616e64206d6f73742070726f6d696e656e74207069656365206f6620776f726b0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_U_Ew1x1aw_B45t6_Vji_Un7keor_RV_Znph_Pm_Rcc3esv_Ba_Tf_Zi_f25fa57a7b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHART>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHART>>(v1);
    }

    // decompiled from Move bytecode v6
}

