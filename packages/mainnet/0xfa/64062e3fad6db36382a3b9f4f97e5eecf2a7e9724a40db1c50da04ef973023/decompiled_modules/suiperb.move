module 0xfa64062e3fad6db36382a3b9f4f97e5eecf2a7e9724a40db1c50da04ef973023::suiperb {
    struct SUIPERB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPERB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPERB>(arg0, 6, b"SUIPERB", b"Suiperb", x"f09f9a80e29ca820426f726e2066726f6d2066756e20616e64206675656c656420627920636f6d6d756e6974792c205375697065726220636f6d62696e65732074686520746872696c6c206f662070726f6669747320f09f92b8207769746820746865206578636974656d656e74206f662073686172656420676f616c7320f09f8eaf2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731860340911.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIPERB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPERB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

