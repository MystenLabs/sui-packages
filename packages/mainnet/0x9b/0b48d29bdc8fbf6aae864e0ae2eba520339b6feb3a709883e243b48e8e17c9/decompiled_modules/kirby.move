module 0x9b0b48d29bdc8fbf6aae864e0ae2eba520339b6feb3a709883e243b48e8e17c9::kirby {
    struct KIRBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIRBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KIRBY>(arg0, 6, b"KIRBY", b"New Baby Elephant", b"New Baby Elephant Houston Zoo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731977885602.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KIRBY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIRBY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

