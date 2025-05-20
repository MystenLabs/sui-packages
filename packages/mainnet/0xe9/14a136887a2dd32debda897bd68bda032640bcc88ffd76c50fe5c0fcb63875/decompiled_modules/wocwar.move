module 0xe914a136887a2dd32debda897bd68bda032640bcc88ffd76c50fe5c0fcb63875::wocwar {
    struct WOCWAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOCWAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOCWAR>(arg0, 6, b"WOCWAR", b"RAWCOW", b"Cow of truth terminal", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihbwt2hkkvrjqnm3ilk7aoywg4xbjubno5gr6g2dkgcvbl4ersih4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOCWAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WOCWAR>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

