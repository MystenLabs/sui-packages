module 0xf284bf94fc1bb0e689dd6dbb8209b7a6b86d76915328143e21f7fdfe8bf0a461::towompx {
    struct TOWOMPX has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOWOMPX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOWOMPX>(arg0, 6, b"TOWOMPX", b"SUI TOWOMPX", x"4d616b65204d656d65636f696e7320477765617420416761696e0a446f6e742042652044776f6d702c204765742053756d2054776f6d700a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bg_mobile_b1a053b164.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOWOMPX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOWOMPX>>(v1);
    }

    // decompiled from Move bytecode v6
}

