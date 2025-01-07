module 0x2ea7cb6e82a3bf52d8375e1e4f67381eb9b8604d8a2b4e98a707fc670d2c5c83::meta {
    struct META has drop {
        dummy_field: bool,
    }

    fun init(arg0: META, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<META>(arg0, 9, b"META", b"Metapod", b"Best pokemon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"data:image/jpeg;base64,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")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<META>(&mut v2, 3000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<META>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<META>>(v1);
    }

    // decompiled from Move bytecode v6
}

