module 0x60c78dd4ff9ec6d9235f9e3d353842d1b1353871cf8c323ba7dfe8a380304a61::ad {
    struct AD has drop {
        dummy_field: bool,
    }

    fun init(arg0: AD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AD>(arg0, 6, b"Ad", b"Adolf", b"jingtao seal", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Snipaste_2024_10_14_13_55_54_5174144c55.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AD>>(v1);
    }

    // decompiled from Move bytecode v6
}

