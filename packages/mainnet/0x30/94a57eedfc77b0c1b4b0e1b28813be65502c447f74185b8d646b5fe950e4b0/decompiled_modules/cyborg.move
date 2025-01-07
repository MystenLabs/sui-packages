module 0x3094a57eedfc77b0c1b4b0e1b28813be65502c447f74185b8d646b5fe950e4b0::cyborg {
    struct CYBORG has drop {
        dummy_field: bool,
    }

    fun init(arg0: CYBORG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CYBORG>(arg0, 6, b"CYBORG", b"Sui Cyborg", x"48616c66206d616368696e652c2068616c66205375692e20244359424f52472069732074686520667574757265206f6620756e73746f707061626c6520706f7765722e2050726f6772616d6d656420666f7220646f6d696e6174696f6e2c2069747320746865207065726665637420626c656e64206f66207465636820616e6420737472656e6774682e200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_2_41e6413ed6.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CYBORG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CYBORG>>(v1);
    }

    // decompiled from Move bytecode v6
}

