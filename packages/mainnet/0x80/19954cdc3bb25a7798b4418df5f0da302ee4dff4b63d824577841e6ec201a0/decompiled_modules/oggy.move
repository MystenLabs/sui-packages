module 0x8019954cdc3bb25a7798b4418df5f0da302ee4dff4b63d824577841e6ec201a0::oggy {
    struct OGGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: OGGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OGGY>(arg0, 6, b"Oggy", b"OggyonSUI", b"Let the mischief begin with $oggy magic!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/fc9vz_Yzq_400x400_145f8c9103.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OGGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OGGY>>(v1);
    }

    // decompiled from Move bytecode v6
}

