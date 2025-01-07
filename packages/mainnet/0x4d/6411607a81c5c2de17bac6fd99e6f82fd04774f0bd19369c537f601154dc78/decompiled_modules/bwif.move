module 0x4d6411607a81c5c2de17bac6fd99e6f82fd04774f0bd19369c537f601154dc78::bwif {
    struct BWIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: BWIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BWIF>(arg0, 6, b"BWIF", b"BLUB WIF HAT", b"BLUB BUT WIF HAT. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4267_1f44c93d3f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BWIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BWIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

