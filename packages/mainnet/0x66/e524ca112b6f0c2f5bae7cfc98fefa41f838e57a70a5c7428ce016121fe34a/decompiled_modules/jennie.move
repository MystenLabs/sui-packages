module 0x66e524ca112b6f0c2f5bae7cfc98fefa41f838e57a70a5c7428ce016121fe34a::jennie {
    struct JENNIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: JENNIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JENNIE>(arg0, 6, b"Jennie", b"Have fun Jennie", x"4974e2809973206a757374206d656d6520616e792064657620616e64207465616d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730970152011.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JENNIE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JENNIE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

