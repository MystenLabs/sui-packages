module 0x7d9a61a84e7ed16bbd5140d26f21aae06d6b71fea8b43ff96a26e62211db0923::priest {
    struct PRIEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRIEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRIEST>(arg0, 6, b"PRIEST", b"CAT-HOLIC PRIEST", x"4341542d484f4c494320245052494553542069730a746865206f6e6c79206d656d65636f696e2077697468206120646976696e650a707572706f73653a20746f20626c65737320796f75722077616c6c65742e204a6f696e0a746865206d6f76656d656e7420616e64206c6574206f75722066656c696e650a70726965737420776f726b20686973206d6167696321", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000034212_90587b2ee6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRIEST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PRIEST>>(v1);
    }

    // decompiled from Move bytecode v6
}

