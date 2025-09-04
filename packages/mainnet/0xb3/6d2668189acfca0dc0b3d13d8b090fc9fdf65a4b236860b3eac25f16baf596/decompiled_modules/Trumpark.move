module 0xb36d2668189acfca0dc0b3d13d8b090fc9fdf65a4b236860b3eac25f16baf596::Trumpark {
    struct TRUMPARK has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPARK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPARK>(arg0, 9, b"TRUMPARK", b"Trumpark", b"you cant make this up", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/media/Gz-zg6KWUAA3BaY?format=jpg&name=large")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMPARK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPARK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

