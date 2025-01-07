module 0x988ee866695dbacf7480b8716abba1730c8a5ebe9e616b76a9e8367a291f428f::TempleOrange {
    struct TEMPLEORANGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEMPLEORANGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEMPLEORANGE>(arg0, 0, b"COS", b"Temple Orange", b"Burn... burn with the whispers of wrongs unseen... and ignite...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Body_Temple_Orange.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEMPLEORANGE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEMPLEORANGE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

