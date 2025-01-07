module 0x1eb5c953fa0134b10fa9e97fc4c1bf5fe38019c5eff5a360f3e7088f1f2f7da5::scat {
    struct SCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCAT>(arg0, 6, b"SCAT", b"Spider Cat", x"5370696465722d43617420697320612073757065726865726f2077686f2073617665732074686520737569206d656d65732e0a0a4c657473206d616b65206d656d6520636f696e7320677265617420616761696e206f6e2074686520535549206e6574776f726b2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0199_9033c78b00.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

