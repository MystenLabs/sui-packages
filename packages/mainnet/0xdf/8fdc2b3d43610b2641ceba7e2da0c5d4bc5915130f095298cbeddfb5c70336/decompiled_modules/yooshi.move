module 0xdf8fdc2b3d43610b2641ceba7e2da0c5d4bc5915130f095298cbeddfb5c70336::yooshi {
    struct YOOSHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: YOOSHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YOOSHI>(arg0, 6, b"YOOSHI", b"WestyInu", x"4166746572206120706572696f64206f66206361726566756c20636f6e73696465726174696f6e20616e642073747261746567696320706c616e6e696e672c206e6f77207468652062657374206d656d65636f696e20594f4f534849204953204241434b202121210a4f555220444953434f52443a68747470733a2f2f646973636f72642e67672f7a426557635a6262", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1722267820896_b11aaaea56a2777a29dea6d25ce39f98_07910fb5a0.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YOOSHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YOOSHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

