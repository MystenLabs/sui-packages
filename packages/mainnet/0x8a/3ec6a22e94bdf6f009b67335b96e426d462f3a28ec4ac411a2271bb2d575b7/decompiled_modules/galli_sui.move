module 0x8a3ec6a22e94bdf6f009b67335b96e426d462f3a28ec4ac411a2271bb2d575b7::galli_sui {
    struct GALLI_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GALLI_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GALLI_SUI>(arg0, 6, b"GALLI_SUI", b"Galli On Sui", b"winner, winner chicken dinner!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiaeyxxdttwrbvsstcsctvpi5pllbq7kbfpyxd4m3n246kqmdu4x3i")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GALLI_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GALLI_SUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

