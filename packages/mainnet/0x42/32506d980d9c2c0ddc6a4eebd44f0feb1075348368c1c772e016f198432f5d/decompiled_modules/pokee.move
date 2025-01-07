module 0x4232506d980d9c2c0ddc6a4eebd44f0feb1075348368c1c772e016f198432f5d::pokee {
    struct POKEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: POKEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POKEE>(arg0, 6, b"POKEE", b"Mr.Pokee", x"497420616c6c207374617274656420776974682061206865646765686f67206e616d656420506f6b65652077686f2074617567687420757320746f20626520686170707920616e6420736d696c650a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/t_Jb_ZOXUX_400x400_e982226667.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POKEE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POKEE>>(v1);
    }

    // decompiled from Move bytecode v6
}

