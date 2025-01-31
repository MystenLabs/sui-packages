module 0xf5389b9e4f5904f3f8616d9589b0b17ad66b242da71ecfed05c16c5f8aaf6fd::dogelon {
    struct DOGELON has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGELON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGELON>(arg0, 6, b"DOGELON", b"Dogelon", b"Missed DOGE going to the moon? Join us on the mission to mars.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000022224_9907b06c2d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGELON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGELON>>(v1);
    }

    // decompiled from Move bytecode v6
}

