module 0xaf3d2a957514755d0562975cba915933f39ecf3d61603d933eb5f58a860154f::beny {
    struct BENY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BENY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BENY>(arg0, 6, b"BENY", b"Beny On Sui", b"BENY is a combination of cat energy and power vibrations, we will unite at movepump in sui to spark a revolution in the crypto world. We are not just another memecoin  we are building united power through culture, code, and community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000062017_f5246c1030.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BENY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BENY>>(v1);
    }

    // decompiled from Move bytecode v6
}

