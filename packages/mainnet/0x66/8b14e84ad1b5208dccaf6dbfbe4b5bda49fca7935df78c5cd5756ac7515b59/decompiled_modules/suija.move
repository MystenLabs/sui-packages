module 0x668b14e84ad1b5208dccaf6dbfbe4b5bda49fca7935df78c5cd5756ac7515b59::suija {
    struct SUIJA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIJA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIJA>(arg0, 6, b"SUIJA", b"Suininja", b"Suininja  the ninja leap of Sui!Suininja  the ninja leap of Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiall3m6wnoml6ikhvgpv7j6dxnjytffjeli7yflproy2n4fbfxnuy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIJA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIJA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

