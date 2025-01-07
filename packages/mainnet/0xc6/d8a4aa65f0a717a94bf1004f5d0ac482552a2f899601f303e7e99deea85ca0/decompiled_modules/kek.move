module 0xc6d8a4aa65f0a717a94bf1004f5d0ac482552a2f899601f303e7e99deea85ca0::kek {
    struct KEK has drop {
        dummy_field: bool,
    }

    fun init(arg0: KEK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KEK>(arg0, 9, b"KEK", b"Kek ", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://blog.meme.com/wp-content/uploads/king-kek-.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<KEK>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KEK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KEK>>(v1);
    }

    // decompiled from Move bytecode v6
}

