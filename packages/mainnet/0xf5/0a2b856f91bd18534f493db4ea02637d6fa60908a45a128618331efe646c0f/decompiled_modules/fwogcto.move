module 0xf50a2b856f91bd18534f493db4ea02637d6fa60908a45a128618331efe646c0f::fwogcto {
    struct FWOGCTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: FWOGCTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FWOGCTO>(arg0, 6, b"FWOGCTO", b"Fwog CTO", b"First CTO on SUI is FWOG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a1888733_701c_4363_b06e_0bb1cb42c29b_e425b09246.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FWOGCTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FWOGCTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

