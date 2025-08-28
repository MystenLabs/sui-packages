module 0x1c7d9196d29fd907cbc2b4b0d099de07937a87144bcbc01d4285c72703803a34::Jumper {
    struct JUMPER has drop {
        dummy_field: bool,
    }

    fun init(arg0: JUMPER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JUMPER>(arg0, 9, b"NO", b"Jumper", b"no jump ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1389092073643515905/ROo_PqDh_400x400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JUMPER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JUMPER>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

