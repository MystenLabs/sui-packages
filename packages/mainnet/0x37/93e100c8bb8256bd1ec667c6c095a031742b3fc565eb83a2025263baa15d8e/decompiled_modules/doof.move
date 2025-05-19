module 0x3793e100c8bb8256bd1ec667c6c095a031742b3fc565eb83a2025263baa15d8e::doof {
    struct DOOF has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOOF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOOF>(arg0, 6, b"DOOF", b"DOOF the DUCK", b"Doof is a clueless degen duck with zero plans and maximum chaos.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicfmgci5kabgsfolmg2vrhtqv64dv4nqeoeqg7tmetzpboctczkpi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOOF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DOOF>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

