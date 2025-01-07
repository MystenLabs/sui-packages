module 0xfafbb2e2267c8d2f6366847cd60272d6e0c53c423115e6bcf834331291312682::papi {
    struct PAPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAPI>(arg0, 6, b"PAPI", b"Papi", b"Psycho isn't enough, I'm crazy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_9045e7ba5d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAPI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PAPI>>(v1);
    }

    // decompiled from Move bytecode v6
}

