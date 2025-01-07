module 0xe1996eae527dd88b13ef977f590f017594581dcf0bb59540ae507b039cc21ac7::suri {
    struct SURI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SURI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SURI>(arg0, 6, b"SURI", b"Suiguri", x"4a6f696e2074686520616476656e74757265207769746820245355524920616e6420656d62726163652074686520737069726974206f6620746865204d6f67757269206f6e207468652053756920636861696e210a2353756967757269", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Photo_16_10_24_12_46_49_AM_4be95a319a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SURI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SURI>>(v1);
    }

    // decompiled from Move bytecode v6
}

