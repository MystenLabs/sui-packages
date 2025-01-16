module 0x93520316dcd81968799c673136a3ed2ad38da3caa255757046cd45273fdd3bef::bullshit {
    struct BULLSHIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BULLSHIT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<BULLSHIT>(arg0, 6, b"BULLSHIT", b"AiBullshit by SuiAI", b"Welcome to 2025, where AI is everywhere, but not everything it does is smart. Enter $bullshit, the sui-based meme token poking fun at how hilariously off-the-mark AI systems can still be", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_2157_ad6ff987ab.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BULLSHIT>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BULLSHIT>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

