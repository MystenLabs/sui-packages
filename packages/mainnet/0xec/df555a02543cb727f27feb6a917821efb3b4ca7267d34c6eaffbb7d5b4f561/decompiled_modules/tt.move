module 0xecdf555a02543cb727f27feb6a917821efb3b4ca7267d34c6eaffbb7d5b4f561::tt {
    struct TT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TT>(arg0, 9, b"TT", b"Test token with 9 decimals", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TT>>(v1);
        0x2::coin::mint_and_transfer<TT>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TT>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

