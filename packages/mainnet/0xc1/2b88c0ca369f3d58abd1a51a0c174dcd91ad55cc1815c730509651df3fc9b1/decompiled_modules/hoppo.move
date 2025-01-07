module 0xc12b88c0ca369f3d58abd1a51a0c174dcd91ad55cc1815c730509651df3fc9b1::hoppo {
    struct HOPPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPPO>(arg0, 6, b"HopPo", b"HopPo Sui", b"Meet $HopPo - the cutest hippo in the sui galaxi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000350_6ea1302bce.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPPO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOPPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

