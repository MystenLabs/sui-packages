module 0x4389ac0e3e579bd05f71d5e12ebeeeee1d605e83014ae2618d14229d59b74d8f::tramp {
    struct TRAMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRAMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRAMP>(arg0, 6, b"TRAMP", b"DONNA TRAMP", b"VOTE DONNA TRAMP ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4068_9e39a42646.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRAMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRAMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

