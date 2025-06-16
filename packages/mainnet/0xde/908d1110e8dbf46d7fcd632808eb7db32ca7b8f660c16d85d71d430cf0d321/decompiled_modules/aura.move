module 0xde908d1110e8dbf46d7fcd632808eb7db32ca7b8f660c16d85d71d430cf0d321::aura {
    struct AURA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AURA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AURA>(arg0, 6, b"AURA", b"aura on sui", b"It cannot be bought or sold it can only be possessed", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeic5ylidstko6j25avzwvnzw673fbzb3hocnjacnanwkowrysiapwe")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AURA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AURA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

