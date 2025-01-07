module 0x21b3a61087d2a343720dcbc4bcf9e36c15ac527fa235106d272c4201f591eb8c::popdog {
    struct POPDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPDOG>(arg0, 6, b"POPDOG", b"POPDOGSUI", b"the dog pops", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/popdog_902e79fd3a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POPDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

