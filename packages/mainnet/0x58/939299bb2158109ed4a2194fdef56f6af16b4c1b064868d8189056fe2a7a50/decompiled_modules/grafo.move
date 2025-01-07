module 0x58939299bb2158109ed4a2194fdef56f6af16b4c1b064868d8189056fe2a7a50::grafo {
    struct GRAFO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRAFO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRAFO>(arg0, 6, b"GRAFO", b"GraphFo", b"The magnetic forces of demonic memesters are no match for GraphFo who is destined to be a future beloved somebody someday.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_2_e68e288007.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRAFO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GRAFO>>(v1);
    }

    // decompiled from Move bytecode v6
}

