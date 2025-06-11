module 0xf74ecf64028d528da52ac6bff54dcb1d3f4a92eb2b66e059544cfa9195a5fa76::testosterone {
    struct TESTOSTERONE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTOSTERONE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTOSTERONE>(arg0, 6, b"TESTOSTERONE", b"TESTO", b"Testosterone is a sex hormone primarily produced by the testicles in males, but also by ovaries in females, and adrenal glands in both sexes.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreig2k5n2isidarvezknltmx6vnvpmtudri3mb65kat7xg5sjkvwbpe")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTOSTERONE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TESTOSTERONE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

