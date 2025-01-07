module 0x7c6ff61b32640f9d76415f0f045ba99aaa4e87c373fa182568bd8e545fb6eddf::sep {
    struct SEP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEP>(arg0, 6, b"SEP", b"SUI EGG PIXEL", x"7375692065676720706978656c2061206d656d6520746f6b656e206f6e2074686520737569206e6574776f726b200a656767206567672065676720656767", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_sui_egg_0e6f40c4c9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEP>>(v1);
    }

    // decompiled from Move bytecode v6
}

