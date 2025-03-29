module 0xc4c15a6cc2f2669b4e2b8c9ae615abac6fa384ecafdd8983e669387dfc44defe::solari {
    struct SOLARI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOLARI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOLARI>(arg0, 9, b"Solari", b"Solari On Sui", b"OG Solana 1965", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmZ8KSgo9skE9vf77KjepdmB8Y7eRcD3fSRFGhD5FKkf43")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SOLARI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SOLARI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOLARI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

