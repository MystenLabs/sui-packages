module 0x5920b47fd80c8a016b7b7da51d303ee54655a664e6eabdb65a83e0052d6f358b::pepesb {
    struct PEPESB has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPESB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPESB>(arg0, 6, b"PepeSB", b"Pepe Sui Beats", x"546865204669727374204d75736963616c204d656d65636f696e204f6e205375692e200a0a20466f722074686520756c74696d6174652072687974686d2120506570652069736ee2809974206a75737420616e79206d7573696320626f740ae280946865e280997320746865206f6666696369616c20444a206f6620746865205375696e6574776f726b2e20576974682068697320776972656c657373206865616470686f6e657320616c77617973206f6e2c0a506570652064656c697665727320746865206265737420626561747320666f7220657665727920766962652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730955880926.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEPESB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPESB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

