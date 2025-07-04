module 0x5768aba3de395958b752ec986f5c2fc65fdd0f7ddfb2c2bcd172259ff8bdfa87::stickman {
    struct STICKMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: STICKMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STICKMAN>(arg0, 9, b"STICK", b"stickman", b"not the stick you're thinking about. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/e0329ecf-0460-49a7-ae1a-05c1d9cb460a.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STICKMAN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STICKMAN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

