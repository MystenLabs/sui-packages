module 0x22c4fc8f08ecadf18f57f799cfbd80f459fb1acf21a04172826d340b13b45852::pxs {
    struct PXS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PXS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PXS>(arg0, 6, b"PXS", b"PatriotXsui", x"57656c636f6d6520746f2050617472696f585375693a2041204e657720457261206f662046726565646f6d2c496e6e6f766174696f6e2c20616e6420416c6c69616e6365210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000001653_7218cb6cc9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PXS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PXS>>(v1);
    }

    // decompiled from Move bytecode v6
}

