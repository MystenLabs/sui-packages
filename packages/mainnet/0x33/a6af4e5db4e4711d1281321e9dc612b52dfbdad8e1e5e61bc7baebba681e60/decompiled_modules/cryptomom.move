module 0x33a6af4e5db4e4711d1281321e9dc612b52dfbdad8e1e5e61bc7baebba681e60::cryptomom {
    struct CRYPTOMOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRYPTOMOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRYPTOMOM>(arg0, 6, b"CryptoMom", b"Crypto Mom (Hester Peirce)", b"Hester Peirce, Crypto Mom, seen as a top pick to replace Gensler for a pro-crypto SEC under Trump.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Gbngr_NXQAAI_6_WS_e8f857efb6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRYPTOMOM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CRYPTOMOM>>(v1);
    }

    // decompiled from Move bytecode v6
}

