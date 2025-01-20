module 0xddc63a428027ca68a02a7284f5bb42ee72991c4440270ad4f1063732f09fe445::suilania {
    struct SUILANIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILANIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILANIA>(arg0, 6, b"SUILANIA", b"SuiLania", b"SuiLania is a revolutionary memecoin inspired by the launch of $MELANIA, designed to celebrate the historic moment of Donald Trump's inauguration as the 47th President of the United States. Built on the fast and efficient SUI network, SuiLania delivers a unique blend of blockchain innovation and global community support for the values of freedom, luxury and leadership.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000045674_c5b8a5c8f6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILANIA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUILANIA>>(v1);
    }

    // decompiled from Move bytecode v6
}

