module 0x6fb8b004c3a8392d181254d5f93544b998d557b367424b692d0751d48190009d::psf_mvmyjud4cv8s {
    struct PSF_MVMYJUD4CV8S has drop {
        dummy_field: bool,
    }

    fun init(arg0: PSF_MVMYJUD4CV8S, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PSF_MVMYJUD4CV8S>(arg0, 9, b"PSF", b"Pump Sui", x"50756d7020537569206f6e2053756920626f6e64696e672063757276652e0a0af09f928a204c61756e63686564206f6e2050756d7053756920e280a22068747470733a2f2f70756d707375692e66756e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aggregator.walrus-mainnet.walrus.space/v1/blobs/bkcIW6bX9C-nOi6W6gpS5WIJTGzD8WLsZqP09_aqBc4")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PSF_MVMYJUD4CV8S>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PSF_MVMYJUD4CV8S>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

