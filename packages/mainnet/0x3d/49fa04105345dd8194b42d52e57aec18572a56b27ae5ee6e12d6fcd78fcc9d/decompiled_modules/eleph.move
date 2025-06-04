module 0x3d49fa04105345dd8194b42d52e57aec18572a56b27ae5ee6e12d6fcd78fcc9d::eleph {
    struct ELEPH has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELEPH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELEPH>(arg0, 6, b"ELEPH", b"(test do not buy)SUI ELEPHANT", b"just elephant on sui  (do not buy) Launching soon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifdfbxicbi6sykxpjodj423737axvxcohxe5k2r6btupqse3t32jm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELEPH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ELEPH>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

