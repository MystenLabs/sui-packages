module 0xdbe413997c84882a3c93c90f3d718e9811eeca4e262b675dbc6771c17d091cc4::izzy {
    struct IZZY has drop {
        dummy_field: bool,
    }

    fun init(arg0: IZZY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IZZY>(arg0, 6, b"IZZY", b"IZZY ON SUI", b"FIRST IZZY ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_1_12_9411971636.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IZZY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IZZY>>(v1);
    }

    // decompiled from Move bytecode v6
}

