module 0x96f6b38a20882b8eb00f88440a13addec6370e5f2f5cbe572993af7342a6c114::capri {
    struct CAPRI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAPRI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAPRI>(arg0, 6, b"Capri", b"Capri Sui", b"Capri - Sui FRUT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sdfsdfsdfsdffsd_7b34cd66c9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAPRI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CAPRI>>(v1);
    }

    // decompiled from Move bytecode v6
}

