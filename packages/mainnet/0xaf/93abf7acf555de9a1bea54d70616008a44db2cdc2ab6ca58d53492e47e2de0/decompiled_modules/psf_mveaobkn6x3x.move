module 0xaf93abf7acf555de9a1bea54d70616008a44db2cdc2ab6ca58d53492e47e2de0::psf_mveaobkn6x3x {
    struct PSF_MVEAOBKN6X3X has drop {
        dummy_field: bool,
    }

    fun init(arg0: PSF_MVEAOBKN6X3X, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PSF_MVEAOBKN6X3X>(arg0, 9, b"PSF", b"Pumpsui", x"50756d70737569206f6e2053756920626f6e64696e672063757276652e0a0af09f928a204c61756e63686564206f6e2050756d7053756920e280a22068747470733a2f2f70756d707375692e66756e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aggregator.walrus-testnet.walrus.space/v1/blobs/PTj-dZif03tlaLp1mm4KfxwC4pIyyz--4nvdo4VIjIc")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PSF_MVEAOBKN6X3X>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PSF_MVEAOBKN6X3X>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

