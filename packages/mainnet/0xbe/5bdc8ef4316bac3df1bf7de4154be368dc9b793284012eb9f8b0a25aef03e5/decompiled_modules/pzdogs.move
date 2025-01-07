module 0xbe5bdc8ef4316bac3df1bf7de4154be368dc9b793284012eb9f8b0a25aef03e5::pzdogs {
    struct PZDOGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PZDOGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PZDOGS>(arg0, 6, b"PZDOGS", b"PanzerDogs", x"50565020706c61792026206561726e2074616e6b20627261776c6572206f6e20537569206279200a6c75636b796b617473747564696f730a20f09f90950a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731007213058.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PZDOGS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PZDOGS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

