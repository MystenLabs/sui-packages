module 0xccdd4849db67d7f96e60e41ce5aaa8a2c352d98b6d226d8d185aca557d0465a0::brettx {
    struct BRETTX has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRETTX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRETTX>(arg0, 9, b"BRETTX", b"Brettium", b"Brettium (BRETTX) is a strong, reliable digital asset on the Sui blockchain, designed for fast, secure, and efficient transactions in a dynamic market.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1823762818388127744/l8C-4boj.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BRETTX>(&mut v2, 200000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRETTX>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRETTX>>(v1);
    }

    // decompiled from Move bytecode v6
}

