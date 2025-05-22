module 0x9be691cd9a7663771bb74daad65cf8a8ada409f792ef2e404c561f6e76a5935f::tt {
    struct TT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TT>(arg0, 7, b"TT", b"Test token with 7 decimals", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TT>>(v1);
        0x2::coin::mint_and_transfer<TT>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TT>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

