module 0x4597a9f101a724c922e596147b5ee1f87fd47b7d8109bfb8ad1543959a5ea6ad::mario {
    struct MARIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MARIO>(arg0, 6, b"MARIO", b"First Mario On Sui(Real)", x"4d6172696f2773206a6f75726e657920746f20636f6e717565722053756920626567696e732e205769746820746865206d697373696f6e20746f206265636f6d652074686520746f70206d656d65206f6e205355492e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/13_552718cea9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MARIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MARIO>>(v1);
    }

    // decompiled from Move bytecode v6
}

