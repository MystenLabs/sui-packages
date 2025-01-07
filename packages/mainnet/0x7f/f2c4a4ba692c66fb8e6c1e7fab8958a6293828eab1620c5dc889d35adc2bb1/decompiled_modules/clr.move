module 0x7ff2c4a4ba692c66fb8e6c1e7fab8958a6293828eab1620c5dc889d35adc2bb1::clr {
    struct CLR has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLR>(arg0, 6, b"CLR", b"Catler", b"a nazi cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730949502769.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CLR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

