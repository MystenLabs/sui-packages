module 0xd14cd19b76f20d3e9f6d0223a378aa5d7ab71dd75fddc5b0f988d2ad99fafc3b::Nobody_Sausage {
    struct NOBODY_SAUSAGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOBODY_SAUSAGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOBODY_SAUSAGE>(arg0, 9, b"NOBODY", b"Nobody Sausage", b"Anybody can be a nobody.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1787440427236302848/jM7cKkLY_400x400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NOBODY_SAUSAGE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOBODY_SAUSAGE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

