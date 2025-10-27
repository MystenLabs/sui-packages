module 0xef88d4b0b15f29ac351b28385e61f187084240044efc3e3cfe6d989dbcae2977::klk {
    struct KLK has drop {
        dummy_field: bool,
    }

    fun init(arg0: KLK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KLK>(arg0, 9, b"klkklk", b"klk", b"klkklkklk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://coinhublogos.9inch.io/1724653538838-chum.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KLK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KLK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

