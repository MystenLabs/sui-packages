module 0xb641f8fe81788123222b164873902c17060bffb5e6d0cb95445ecb8363c89160::da {
    struct DA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DA>(arg0, 6, b"DA", b"DunA", b"test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1765793819601.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

