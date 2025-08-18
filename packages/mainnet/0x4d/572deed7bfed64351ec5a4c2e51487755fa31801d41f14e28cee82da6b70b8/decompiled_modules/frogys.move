module 0x4d572deed7bfed64351ec5a4c2e51487755fa31801d41f14e28cee82da6b70b8::frogys {
    struct FROGYS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROGYS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FROGYS>(arg0, 6, b"Frogys", b"Frogy Sui", b"gero gero gero", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeifpa3ucgytf7jpyjatuzcgroxegbdrpfvtoauqrf7w46nahv7yt34")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FROGYS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FROGYS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

