module 0xfd6891d4624154d438e68e5ad081f0cfe2241fe17af907aa154899ad0604a256::sui_simpson {
    struct SUI_SIMPSON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI_SIMPSON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI_SIMPSON>(arg0, 9, b"SUI SIMPSON", x"e2ad90efb88f5375692053696d70736f6e", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUI_SIMPSON>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI_SIMPSON>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUI_SIMPSON>>(v1);
    }

    // decompiled from Move bytecode v6
}

