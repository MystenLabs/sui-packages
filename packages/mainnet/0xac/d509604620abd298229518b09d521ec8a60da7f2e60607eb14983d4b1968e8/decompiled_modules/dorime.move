module 0xacd509604620abd298229518b09d521ec8a60da7f2e60607eb14983d4b1968e8::dorime {
    struct DORIME has drop {
        dummy_field: bool,
    }

    fun init(arg0: DORIME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DORIME>(arg0, 6, b"DORIME", b"Dorime on SUI", x"54686520686f6c79207261742e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/29tbdr_X_400x400_74d35425e6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DORIME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DORIME>>(v1);
    }

    // decompiled from Move bytecode v6
}

