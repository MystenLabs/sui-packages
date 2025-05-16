module 0x44b47edc3fdf1033eeae279af08c274e68d4e312eda5cce79661a69ec44dedba::poppi {
    struct POPPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPPI>(arg0, 6, b"Poppi", b"Poppi SUI", b"poppi on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreih47d6oa2miqgglflxmh3iho2fy24ifqja3zfufvthhlcssu7wxsq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPPI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<POPPI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

