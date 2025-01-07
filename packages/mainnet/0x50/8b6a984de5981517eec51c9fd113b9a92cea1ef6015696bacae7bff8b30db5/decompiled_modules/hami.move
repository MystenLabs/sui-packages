module 0x508b6a984de5981517eec51c9fd113b9a92cea1ef6015696bacae7bff8b30db5::hami {
    struct HAMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAMI>(arg0, 6, b"Hami", b"Hami on Sui", x"48616d69206973206e6f77206f6e2074686520537569204e6574776f726b2e0a4e6f77206c65742773206275696c64206f757220636f6d6d756e697479206f6e205375692e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Hamisui_d29d5670eb.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HAMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

