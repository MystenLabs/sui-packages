module 0x27fda82408a5194becb9e286eceb7d0b7bb8fc3d5eddca572cd5dbfd36c156c9::win {
    struct WIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIN>(arg0, 9, b"WIN", b"0xe6b9e1033c72084ad01db37c77778ca53b9c4ebb263f28ffbfed39f4d5fd5057::win::WIN", b"Licensed Casino with no KYC & Instant Cash Out.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://launchpad.turbos.finance/wintoken.254e43002babf5b30d3151a09cb56115.svg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<WIN>>(0x2::coin::mint<WIN>(&mut v2, 10000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<WIN>>(v2);
    }

    // decompiled from Move bytecode v6
}

