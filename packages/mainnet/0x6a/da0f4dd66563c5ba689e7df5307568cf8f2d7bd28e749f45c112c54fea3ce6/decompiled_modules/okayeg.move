module 0x6ada0f4dd66563c5ba689e7df5307568cf8f2d7bd28e749f45c112c54fea3ce6::okayeg {
    struct OKAYEG has drop {
        dummy_field: bool,
    }

    fun init(arg0: OKAYEG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OKAYEG>(arg0, 6, b"OKAYEG", b"Okayeg", x"4f6b61796567206973206f6e65206f6620746865206d6f737420706f70756c61722054776974636820656d6f7465206d656d657320616e6420686173206e6f77206265636f6d652061206d656d6520746f6b656e210a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/r9_Pon_Enr_400x400_ec9dec8c57.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OKAYEG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OKAYEG>>(v1);
    }

    // decompiled from Move bytecode v6
}

