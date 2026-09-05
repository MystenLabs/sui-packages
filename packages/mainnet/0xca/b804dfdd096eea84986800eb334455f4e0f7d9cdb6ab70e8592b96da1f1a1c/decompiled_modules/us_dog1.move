module 0xcab804dfdd096eea84986800eb334455f4e0f7d9cdb6ab70e8592b96da1f1a1c::us_dog1 {
    struct US_DOG1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: US_DOG1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<US_DOG1>(arg0, 6, b"US_DOG1", b"US_DOG", b"Bullish one day 1000X US_DOG_1000X", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1788630455587.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<US_DOG1>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<US_DOG1>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

