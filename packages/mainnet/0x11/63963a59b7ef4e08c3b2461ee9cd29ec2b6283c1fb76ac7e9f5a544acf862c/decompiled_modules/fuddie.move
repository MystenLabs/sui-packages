module 0x1163963a59b7ef4e08c3b2461ee9cd29ec2b6283c1fb76ac7e9f5a544acf862c::fuddie {
    struct FUDDIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUDDIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUDDIE>(arg0, 6, b"Fuddie", b"Fuddies", b"Extra special owls means an extra special community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3a89ff90adc8d50ccbdeac61ac4a2223_bbe5c739aa.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUDDIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUDDIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

