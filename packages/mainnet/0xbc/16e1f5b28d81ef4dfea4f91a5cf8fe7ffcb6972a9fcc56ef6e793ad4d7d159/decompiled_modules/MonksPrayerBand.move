module 0xbc16e1f5b28d81ef4dfea4f91a5cf8fe7ffcb6972a9fcc56ef6e793ad4d7d159::MonksPrayerBand {
    struct MONKSPRAYERBAND has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONKSPRAYERBAND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONKSPRAYERBAND>(arg0, 0, b"COS", b"Monk's Prayer Band", b"A nod from the Worshippers... for they sense the power in this, even if no one can see it...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Head_Monk's_Prayer_Band.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MONKSPRAYERBAND>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONKSPRAYERBAND>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

