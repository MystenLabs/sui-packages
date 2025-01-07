module 0x6768df0c753a38ecafd63f9cc0e3f83fb6184992fd0b86143a90bb30609b7a86::ssui {
    struct SSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSUI>(arg0, 6, b"SSUI", b"SUPER SUI", x"6920616d205375706572205375690a7468652050726f746563746f72206f66205375692045636f73797374656d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/supersui_87edd62f1f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

