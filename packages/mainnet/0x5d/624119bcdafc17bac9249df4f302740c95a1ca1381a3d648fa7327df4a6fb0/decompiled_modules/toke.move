module 0x5d624119bcdafc17bac9249df4f302740c95a1ca1381a3d648fa7327df4a6fb0::toke {
    struct TOKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOKE>(arg0, 9, b"Toke", b"Toke", b"The token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TOKE>(&mut v2, 9000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

