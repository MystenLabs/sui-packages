module 0x6fdcff9f3942040e067cd24a89746b3c24f660f30c2b667b34db25949e534639::sdae {
    struct SDAE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDAE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDAE>(arg0, 6, b"SDAE", b"SuidaeBot", x"54686520666972737420616e6420666173746573743a20596f7572205375692063727970746f206d756c74692d746f6f6c2e0a547279206f7574206e657720646567656e2074726164696e6720657870657269656e6365210a436865636b206f757220646f637320666f72206f7468657220696e666f3a2068747470733a2f2f646f63732e737569646165626f742e636f6d2f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/el_WV_c3_Q_400x400_bebd6dbb08.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDAE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SDAE>>(v1);
    }

    // decompiled from Move bytecode v6
}

