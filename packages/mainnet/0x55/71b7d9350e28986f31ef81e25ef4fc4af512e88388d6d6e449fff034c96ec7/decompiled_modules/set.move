module 0x5571b7d9350e28986f31ef81e25ef4fc4af512e88388d6d6e449fff034c96ec7::set {
    struct SET has drop {
        dummy_field: bool,
    }

    fun init(arg0: SET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SET>(arg0, 6, b"SET", b"Suiet", b"The wallet built for SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732116252091.avif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SET>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SET>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

