module 0x55a2e23c13a6a26b096a3559e00186110488134310cb7e59ac35cfc7c8cd52b1::xmas {
    struct XMAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: XMAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XMAS>(arg0, 6, b"Xmas", b"Xmas Sui", b"Dec 25th", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/39_BC_14_D4_D58_E_4_E47_B2_F0_F396_D5_FC_1152_793d345b18.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XMAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XMAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

