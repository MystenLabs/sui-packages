module 0x399d00c46d77e51501fa7db88e388edef14e3a032abeb0c0b3682b64c686a21b::goobz {
    struct GOOBZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOOBZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOOBZ>(arg0, 6, b"GOOBZ", b"Sui Goobz", b"Goobz the first rule of $GOOBZ? You pretend you knew about $GOOBZ  first.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiallds7wxl4lt5e5fx7a37dgfx7ogluanrdzrvewztfakgfkp7a4y")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOOBZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GOOBZ>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

