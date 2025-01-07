module 0xec4f6863aaf39fae57d58fa2e8b978124e242371ee10b32a506f307cfbeca698::wif {
    struct WIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIF>(arg0, 6, b"Wif", b"wif", b"Popular meme Dogwifhat vibes wif frens onchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731044913473.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WIF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIF>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

