module 0xd6609213dda1f943ca0ed6a3ad3aebe40343cbadee1de8560134dcdbdfd97fee::tport {
    struct TPORT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TPORT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TPORT>(arg0, 9, b"TPORT", b"TradePort", b"Multichain trading platform aggregating NFTs from all marketplaces across Movement, Base, Sui, Aptos, Near, and Stacks.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1793293858656141312/n3yggKYf_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TPORT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<TPORT>>(0x2::coin::mint<TPORT>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TPORT>>(v2);
    }

    // decompiled from Move bytecode v6
}

