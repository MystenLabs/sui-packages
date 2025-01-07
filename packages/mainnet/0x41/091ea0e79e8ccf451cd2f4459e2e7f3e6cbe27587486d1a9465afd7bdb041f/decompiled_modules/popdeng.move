module 0x41091ea0e79e8ccf451cd2f4459e2e7f3e6cbe27587486d1a9465afd7bdb041f::popdeng {
    struct POPDENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPDENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPDENG>(arg0, 6, b"PopDeng", b"POPDENG ON SUI", x"0a506f702044656e67206973206865726520746f206d616b6520697473206f776e2073706c617368206f6e207468652053756920626c6f636b636861696e2e2057697468207468652062657374206f6620626f746820776f726c64736d656d65206d61646e65737320616e64206d6f6f6e2d626f756e6420616d626974696f6e506f702044656e6720697320726561647920746f20706f756e636520616e6420706f70206974732077617920746f20746865206d6f6f6e210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241013_235259_844_19ae74dff3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPDENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POPDENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

