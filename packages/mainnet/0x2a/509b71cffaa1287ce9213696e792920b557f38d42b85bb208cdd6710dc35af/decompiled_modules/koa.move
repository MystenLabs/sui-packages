module 0x2a509b71cffaa1287ce9213696e792920b557f38d42b85bb208cdd6710dc35af::koa {
    struct KOA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOA>(arg0, 6, b"KOA", b"KING OF AMERICA", b"The Only King of America ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1001870332_4975c960b5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KOA>>(v1);
    }

    // decompiled from Move bytecode v6
}

