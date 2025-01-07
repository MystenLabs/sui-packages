module 0x4d1281ff81d474d9a27a1b858e7340b456f682be683fde14f26828db43d87aa6::bits {
    struct BITS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BITS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BITS>(arg0, 6, b"BITS", b"Dino bits", x"506978656c73203e2024200a456d70686173697a6573207468652076616c7565206f6620637265617469766974792c207175616c6974792c20616e6420696e6e6f766174696f6e206f766572206d6572652070726f6669742e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Dyno_b2ab430b07.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BITS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BITS>>(v1);
    }

    // decompiled from Move bytecode v6
}

