module 0xf91d8f9111bbbabf11c567c29a1294d2ca3b9b5ed2ec8f08829b1781d8249cd5::size {
    struct SIZE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIZE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIZE>(arg0, 11, b"SIZE", b"SIZE", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b" ")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SIZE>(&mut v2, 100000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIZE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIZE>>(v1);
    }

    // decompiled from Move bytecode v6
}

