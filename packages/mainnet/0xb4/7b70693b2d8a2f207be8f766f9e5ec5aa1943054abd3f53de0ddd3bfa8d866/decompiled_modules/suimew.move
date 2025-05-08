module 0xb47b70693b2d8a2f207be8f766f9e5ec5aa1943054abd3f53de0ddd3bfa8d866::suimew {
    struct SUIMEW has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMEW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMEW>(arg0, 6, b"SUIMEW", b"SuiMew Pokemon", b"$SUIMEW MAKE SUI GREAT AGAIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidfduarfyh62sgcbkludspzgtob5o2pitxch2whxspl6rp2xyjcai")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMEW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIMEW>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

