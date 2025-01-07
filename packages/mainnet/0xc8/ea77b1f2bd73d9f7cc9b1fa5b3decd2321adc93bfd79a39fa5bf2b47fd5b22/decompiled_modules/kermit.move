module 0xc8ea77b1f2bd73d9f7cc9b1fa5b3decd2321adc93bfd79a39fa5bf2b47fd5b22::kermit {
    struct KERMIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: KERMIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KERMIT>(arg0, 6, b"KERMIT", b"KERMIT SUI", x"4b45524d4954205468652046726f670a0a5468652047726561746573742046726f67206f6620416c6c2054696d652c0a5468652050657065204b696c6c65722e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/games_76aa1b144d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KERMIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KERMIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

