module 0x35d31053da220c12e196b053fe1cd20ee635001d8c81dce7a3f14e9c583713c::ballsy {
    struct BALLSY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BALLSY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BALLSY>(arg0, 6, b"BALLSY", b"Ballsy on Sui", x"47726162206c696665206279207468652062616c6c7320776974682042616c6c73790a0a42616c6c737920697320796f757220756e61706f6c6f676574696320646567656e2073706972697420616e696d616c0a0a4772616220796f75722042616c6c7379200a486f6c642074696768740a616e64206a6f696e207468652072696465", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiakwc5qdp2kognvxfqhtdw5aalsswau2635bx65e7ns6i3xnp3qam")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BALLSY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BALLSY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

