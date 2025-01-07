module 0xfb79ce7d56cc74eaf546a88e5382b8340f63fe998df86dd1823010e4fa3895d2::pov {
    struct POV has drop {
        dummy_field: bool,
    }

    fun init(arg0: POV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POV>(arg0, 6, b"POV", b"CAT POV", b"pov : being a cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/catpov_6d1030d6ae.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POV>>(v1);
    }

    // decompiled from Move bytecode v6
}

