module 0x5dbd50b4d97b2a86843e309ac14888a22c0d84c1335a9d5a102e9ef6fb2fc63b::stl {
    struct STL has drop {
        dummy_field: bool,
    }

    fun init(arg0: STL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STL>(arg0, 9, b"STL", b"SuiTail", b"Meme test, are you coming or not?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<STL>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STL>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STL>>(v1);
    }

    // decompiled from Move bytecode v6
}

