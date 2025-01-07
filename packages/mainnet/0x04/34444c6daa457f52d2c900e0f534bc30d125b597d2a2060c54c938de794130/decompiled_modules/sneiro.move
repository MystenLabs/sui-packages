module 0x434444c6daa457f52d2c900e0f534bc30d125b597d2a2060c54c938de794130::sneiro {
    struct SNEIRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNEIRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNEIRO>(arg0, 6, b"SNEIRO", b"Sui Neiro", x"54686520736973746572206f66204b61626f737520446f67652e0a0a244e6569726f206973206120636f6d6d756e6974792d6d616e616765642070726f6a656374207769746820616e20656d706861736973206f6e206368617269747920616e6420646f696e67206f6e6c7920676f6f642065766572796461792e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sneiro_3b7b264381.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNEIRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNEIRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

