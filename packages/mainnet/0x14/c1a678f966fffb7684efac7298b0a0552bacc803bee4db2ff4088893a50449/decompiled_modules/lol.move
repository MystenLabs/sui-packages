module 0x14c1a678f966fffb7684efac7298b0a0552bacc803bee4db2ff4088893a50449::lol {
    struct LOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOL>(arg0, 6, b"LOL", b"Lol", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOL>>(v0, v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LOL>>(v1, v2);
    }

    // decompiled from Move bytecode v7
}

