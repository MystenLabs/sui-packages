module 0x50174dbcd423be29eefb2bacad54d2d3f8a59fbad4a88a42331f364518a026c6::kabosui {
    struct KABOSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KABOSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KABOSUI>(arg0, 6, b"KABOSUI", b"KaboSui The Emperor", b"The most powerful empawroar to ever set foot in Sui!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6089260686896120355_1_9723f97ff9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KABOSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KABOSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

