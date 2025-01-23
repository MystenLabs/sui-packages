module 0x1cb992565cd2c0a10df9a0a5b242d4837e6c1ec99f312ee67e2b4a0145a5c675::tendy {
    struct TENDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TENDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TENDY>(arg0, 6, b"TENDY", b"Tendies", x"54454e44592069732074686520233120746f6b656e206f6e2074686520696e7465726e657420636f6d70757465722e204d616e6167656420627920426974636f726e206c6162732c2074656e646965732061726520696e6e6f7661746f7273206f6620776562332e2049747320616c736f2061207069656365206f6620667269656420636869636b656e2e0a54454e44592e7a6f6e6520626974636f726e6c6162732e646576", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7749_7b25bf18c7.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TENDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TENDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

