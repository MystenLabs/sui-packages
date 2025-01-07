module 0x995ec96f0f91a4597182c415717db67f70c12206460315dfffde587a7e6584e4::link {
    struct LINK has drop {
        dummy_field: bool,
    }

    fun init(arg0: LINK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LINK>(arg0, 6, b"LINK", b"link", x"4c696e6b466f72676520697320616e20696e6e6f7661746976652070726f6a6563742061696d656420617420696e74726f647563696e672074686520706f70756c617220426c696e6b2070726f746f636f6c2066726f6d2074686520536f6c616e612065636f73797374656d20746f207468652053756920626c6f636b636861696e2e205468697320696e697469617469766520676f6573206265796f6e64206d65726520746563686e6963616c206d6967726174696f6e0a0a68747470733a2f2f6c696e6b2e777261707065722e7370616365", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_CORAL_f3af046756.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LINK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LINK>>(v1);
    }

    // decompiled from Move bytecode v6
}

