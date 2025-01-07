module 0xebb3b80fdc8fb0ae5c247f2ecaecc9720a28b8beb91b9f04022315357f1c1e15::suigray {
    struct SUIGRAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGRAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGRAY>(arg0, 9, b"SUIGRAY", b"SUIGRAY", b"SUI GRAY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIGRAY>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGRAY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGRAY>>(v1);
    }

    // decompiled from Move bytecode v6
}

