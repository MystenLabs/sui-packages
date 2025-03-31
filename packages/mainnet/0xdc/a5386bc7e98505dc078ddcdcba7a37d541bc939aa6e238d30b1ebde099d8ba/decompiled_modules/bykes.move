module 0xdca5386bc7e98505dc078ddcdcba7a37d541bc939aa6e238d30b1ebde099d8ba::bykes {
    struct BYKES has drop {
        dummy_field: bool,
    }

    fun init(arg0: BYKES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BYKES>(arg0, 6, b"BYKES", b"SUI MOTORS", x"312d626c756520616e6420776869746520696e2072656420776f72647320436f696e2042594b455320322d564f5445204e455854205354455020332d746f20626520636f6e74696e7565642e2e2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9677_2b54924c46.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BYKES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BYKES>>(v1);
    }

    // decompiled from Move bytecode v6
}

