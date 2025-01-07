module 0xb9bd4a5eda04b09eb34d36975ce1e9435392b2c2a878d21ba889c8e490c60ac::suiluna {
    struct SUILUNA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILUNA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILUNA>(arg0, 9, b"suiluna", b"suiluna", b"sui8932", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUILUNA>(&mut v2, 12324421000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILUNA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUILUNA>>(v1);
    }

    // decompiled from Move bytecode v6
}

