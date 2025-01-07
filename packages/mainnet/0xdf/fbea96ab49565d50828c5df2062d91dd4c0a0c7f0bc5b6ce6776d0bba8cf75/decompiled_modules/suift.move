module 0xdffbea96ab49565d50828c5df2062d91dd4c0a0c7f0bc5b6ce6776d0bba8cf75::suift {
    struct SUIFT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIFT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIFT>(arg0, 6, b"SUIFT", b"Taylor Suift", b"Taylor Suift - Paradoy account. Living out the life of Miss Suift on the Move blockchain of choice; SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0x2b088965d99ced67268161135076749e27761ecdcd76b06bd50ba5fe16231095_suift_suift_78d696ff8d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIFT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIFT>>(v1);
    }

    // decompiled from Move bytecode v6
}

