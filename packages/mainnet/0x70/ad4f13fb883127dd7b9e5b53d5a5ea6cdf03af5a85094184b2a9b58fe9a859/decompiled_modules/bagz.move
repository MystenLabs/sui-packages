module 0x70ad4f13fb883127dd7b9e5b53d5a5ea6cdf03af5a85094184b2a9b58fe9a859::bagz {
    struct BAGZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAGZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAGZ>(arg0, 6, b"BAGZ", b"Bagzilla", b"Big bags. Big risk. Bigger cope", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihus7npmulrunfzybyoqwv33dvzutt57suaonh4ssoefspux2ho4i")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAGZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BAGZ>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

