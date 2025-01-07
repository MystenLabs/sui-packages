module 0xf050e62edc493d4d73307254920569bf1c7b49377cab89587c8b593fc511aa14::hammy {
    struct HAMMY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAMMY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAMMY>(arg0, 6, b"Hammy", b"Hammy on Sui", x"48616d6d7920746865206f6666696369616c2048616d6d79206f66205375690a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_67815b8499.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAMMY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HAMMY>>(v1);
    }

    // decompiled from Move bytecode v6
}

