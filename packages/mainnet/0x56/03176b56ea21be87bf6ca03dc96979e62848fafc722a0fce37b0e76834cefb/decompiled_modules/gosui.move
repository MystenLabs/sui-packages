module 0x5603176b56ea21be87bf6ca03dc96979e62848fafc722a0fce37b0e76834cefb::gosui {
    struct GOSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOSUI>(arg0, 6, b"GOSUI", b"GARY ON SUI", b"The long lost child of Brett.  Join Gary on his cosmic adventure, exploring the bonds of family across space and time along the SUI Chain. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_28_00_19_40_9cb4ce67ea.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

