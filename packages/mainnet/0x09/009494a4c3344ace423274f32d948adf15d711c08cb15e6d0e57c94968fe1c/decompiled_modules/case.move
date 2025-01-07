module 0x9009494a4c3344ace423274f32d948adf15d711c08cb15e6d0e57c94968fe1c::case {
    struct CASE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CASE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CASE>(arg0, 6, b"CASE", b"CAT SEXY", b"CAT SEXY CAT SEXY CAT SEXY CAT SEXY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/z5292552491537_6bf6ffc923953643090d52611aad88d8_a8abd3a5cc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CASE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CASE>>(v1);
    }

    // decompiled from Move bytecode v6
}

