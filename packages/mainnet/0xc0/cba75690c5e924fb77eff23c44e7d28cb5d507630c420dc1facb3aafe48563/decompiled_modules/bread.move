module 0xc0cba75690c5e924fb77eff23c44e7d28cb5d507630c420dc1facb3aafe48563::bread {
    struct BREAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BREAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BREAD>(arg0, 6, b"BREAD", b"SUI BREAD", b"The most delicious bread on SUI, partner with hot chocolate or coffee while posting GM on X", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731943651858.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BREAD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BREAD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

