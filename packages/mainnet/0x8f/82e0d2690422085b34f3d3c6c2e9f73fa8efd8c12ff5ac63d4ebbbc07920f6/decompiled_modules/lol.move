module 0x8f82e0d2690422085b34f3d3c6c2e9f73fa8efd8c12ff5ac63d4ebbbc07920f6::lol {
    struct LOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOL>(arg0, 9, b"Lol", b"Olole", b"Meh", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/9421628c5b365677e63f62053de58ea7blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LOL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

