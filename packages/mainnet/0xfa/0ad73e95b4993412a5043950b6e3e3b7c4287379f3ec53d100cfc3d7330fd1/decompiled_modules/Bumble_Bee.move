module 0xfa0ad73e95b4993412a5043950b6e3e3b7c4287379f3ec53d100cfc3d7330fd1::Bumble_Bee {
    struct BUMBLE_BEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUMBLE_BEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUMBLE_BEE>(arg0, 9, b"BEE", b"Bumble Bee", b"busy little bee.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/cc6364a3-feaf-4f65-b1dc-a750335baba6.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BUMBLE_BEE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUMBLE_BEE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

