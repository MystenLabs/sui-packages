module 0x8135a5226697098ed955feee4a2e47d1b04aa96fdc71cc60931cd56d5aab35fc::beer {
    struct BEER has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEER>(arg0, 6, b"BEER", b"Sui Beer", b"Beer is praying to the lord that you make it before it goes nuts. This polite bear loves to scratch his back on the trees, but if you jeet be sure you'll be instead of that tree.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_2024_06_18_T002523_663_30435825d9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEER>>(v1);
    }

    // decompiled from Move bytecode v6
}

