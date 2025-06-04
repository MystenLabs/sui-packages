module 0xade24c888344c2cb94d5caa7f016b5de77ff3a40bb72f7ac485a4b014adde538::phat {
    struct PHAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PHAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PHAT>(arg0, 6, b"PHAT", b"(test do not buy) ELEPHAT", b"(test do not buy)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifdfbxicbi6sykxpjodj423737axvxcohxe5k2r6btupqse3t32jm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PHAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PHAT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

