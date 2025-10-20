module 0x6bbe0970ca12f5e2cc4d865c4b30b79ac709ceb39896ede5a45f054a5fbaee9b::tmp {
    struct TMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TMP>(arg0, 9, b"TMP", b"Template", b"Template Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TMP>(&mut v2, 21000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TMP>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

