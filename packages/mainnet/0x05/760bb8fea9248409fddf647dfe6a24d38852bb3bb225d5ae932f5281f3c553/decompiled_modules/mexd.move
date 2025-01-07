module 0x5760bb8fea9248409fddf647dfe6a24d38852bb3bb225d5ae932f5281f3c553::mexd {
    struct MEXD has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEXD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEXD>(arg0, 6, b"MEXD", b"Mexican Dog", b"Living the ruff life, one cerveza at a time.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1647_1466bfab73.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEXD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEXD>>(v1);
    }

    // decompiled from Move bytecode v6
}

