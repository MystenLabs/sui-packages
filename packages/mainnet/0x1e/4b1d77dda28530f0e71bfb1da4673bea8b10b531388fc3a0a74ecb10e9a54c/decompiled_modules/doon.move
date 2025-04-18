module 0x1e4b1d77dda28530f0e71bfb1da4673bea8b10b531388fc3a0a74ecb10e9a54c::doon {
    struct DOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOON>(arg0, 6, b"DOON", b"Doonies Bags", b"Meet Los Doonies by Dead Skull Society!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreib36cz2plnhxailgkry4cnknenex4tdgwa6laz5r5iqmc5uuqt4b4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DOON>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

