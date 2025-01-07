module 0x6ff43158b36a6fd096257c0c1c1722a090615526ee9f8dbdcf0f568934c416fb::sss {
    struct SSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSS>(arg0, 6, b"SSS", b"Snake Wif Hat on SUI", x"f09f94a52057652061726520636f6e74696e75696e67207468652024776966206c65676163792e20f09f94a50a0a446f677320616e642063617473206861642074686569722074696d652e204974732074696d65207765206d616b6520736e616b6573206375746520616761696e2e20f09f908d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732379978355.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SSS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

