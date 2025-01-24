module 0xdd7c820a6f89646f1c24a157d50aa76f4088e238e2b631c1a60a85cbbbc9bf38::oiiai {
    struct OIIAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: OIIAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<OIIAI>(arg0, 6, b"OIIAI", b"oiiaicat by SuiAI", b"meme of oiiai cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/oiiai_7b86224616.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<OIIAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OIIAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

