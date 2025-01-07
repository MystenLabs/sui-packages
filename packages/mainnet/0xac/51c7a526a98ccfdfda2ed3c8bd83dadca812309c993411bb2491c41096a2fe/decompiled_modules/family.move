module 0xac51c7a526a98ccfdfda2ed3c8bd83dadca812309c993411bb2491c41096a2fe::family {
    struct FAMILY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAMILY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAMILY>(arg0, 6, b"FAMILY", b"FAMILY SUI", b"Let's go drink until we can't feel feelings anymore. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_2024_10_13_T211809_990_470ebe3c88.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAMILY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FAMILY>>(v1);
    }

    // decompiled from Move bytecode v6
}

