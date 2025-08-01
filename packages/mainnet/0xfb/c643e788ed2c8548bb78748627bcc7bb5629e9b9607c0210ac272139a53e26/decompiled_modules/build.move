module 0xfbc643e788ed2c8548bb78748627bcc7bb5629e9b9607c0210ac272139a53e26::build {
    struct BUILD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUILD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUILD>(arg0, 6, b"BUILD", b"build project ", b"build project  build project ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1754018989582.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BUILD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUILD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

