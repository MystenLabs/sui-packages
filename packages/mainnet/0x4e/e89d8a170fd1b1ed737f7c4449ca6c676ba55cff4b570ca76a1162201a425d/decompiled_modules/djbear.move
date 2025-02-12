module 0x4ee89d8a170fd1b1ed737f7c4449ca6c676ba55cff4b570ca76a1162201a425d::djbear {
    struct DJBEAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: DJBEAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DJBEAR>(arg0, 6, b"DJBear", b"DJ Bear On Sui", b"Participate in events: We will organize online and offline music events. Join to meet like-minded people and enjoy great music.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/7_1526ec8e7c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DJBEAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DJBEAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

