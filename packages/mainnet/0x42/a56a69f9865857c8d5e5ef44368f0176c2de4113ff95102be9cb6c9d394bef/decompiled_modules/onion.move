module 0x42a56a69f9865857c8d5e5ef44368f0176c2de4113ff95102be9cb6c9d394bef::onion {
    struct ONION has drop {
        dummy_field: bool,
    }

    fun init(arg0: ONION, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ONION>(arg0, 6, b"Onion", b"Magic Onion", b"In ancient Egypt, onions were used as currency to pay the workers who built the pyramids. They were so revered that they were even placed in the tombs of pharaohs as an offering.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GZA_wd_W_Wg_AAGQ_Yz_97c521aa62.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ONION>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ONION>>(v1);
    }

    // decompiled from Move bytecode v6
}

