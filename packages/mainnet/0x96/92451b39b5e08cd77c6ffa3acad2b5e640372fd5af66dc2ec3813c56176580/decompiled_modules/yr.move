module 0x9692451b39b5e08cd77c6ffa3acad2b5e640372fd5af66dc2ec3813c56176580::yr {
    struct YR has drop {
        dummy_field: bool,
    }

    fun init(arg0: YR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YR>(arg0, 6, b"YR", b"Main", b"dont buy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1757070868305.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

