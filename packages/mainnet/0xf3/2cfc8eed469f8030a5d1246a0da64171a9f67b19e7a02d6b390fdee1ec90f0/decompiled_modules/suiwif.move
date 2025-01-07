module 0xf32cfc8eed469f8030a5d1246a0da64171a9f67b19e7a02d6b390fdee1ec90f0::suiwif {
    struct SUIWIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIWIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIWIF>(arg0, 6, b"SUIWIF", b"SUI WIF", x"f09f92a753554920574946f09f92a73a2054686520756c74696d617465206d656d6520636f696e206472697070696e67207769746820646567656e2076696265732e205a65726f207574696c6974792c2031303025207761676d6920656e657267792e205269646520746865207761766520f09f8c8a2c20737461636b20746865206761696e7320f09f92b02c20616e6420666c657820796f7572206861742067616d652e20446f6ee280997420676574206c65667420626568696e6420e28093202a2a24535549205749462a2a206973206865726520746f2077657420746865206d61726b65742120f09f9a80", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734095603137.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIWIF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIWIF>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

