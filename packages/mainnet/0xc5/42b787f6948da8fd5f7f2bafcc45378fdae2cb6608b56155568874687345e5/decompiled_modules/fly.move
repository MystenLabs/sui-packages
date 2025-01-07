module 0xc542b787f6948da8fd5f7f2bafcc45378fdae2cb6608b56155568874687345e5::fly {
    struct FLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLY>(arg0, 6, b"FLY", b"Flying Unicorn To 100M", b"Flying Unicorn To 100M.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Y_Vx2_Wp_Fpyx_S8puqdqqyhrom_X_Hw8_Cvi6_Lk1_WT_Gahzr_Uq_C_744558a938.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

