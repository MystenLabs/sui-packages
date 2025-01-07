module 0x48a1d088f42517dec7c3ded97ae79b362f6359b851d3f809dc0f0b5191003cae::soap {
    struct SOAP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOAP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOAP>(arg0, 6, b"SOAP", b"CZ Dropped The Soap", x"556e666f7274756e6174656c792c20647572696e67206869732074696d6520696e20707269736f6e2c20435a206d61646520746865206d697374616b65206f662064726f7070696e672074686520736f61702e0a342074696d65732e2e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/soap_PNG_43_797c0e4a37.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOAP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOAP>>(v1);
    }

    // decompiled from Move bytecode v6
}

