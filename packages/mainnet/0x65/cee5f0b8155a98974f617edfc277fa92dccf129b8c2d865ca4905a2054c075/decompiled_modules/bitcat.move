module 0x65cee5f0b8155a98974f617edfc277fa92dccf129b8c2d865ca4905a2054c075::bitcat {
    struct BITCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BITCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BITCAT>(arg0, 6, b"BITCAT", b"8BIT CAT", b"8-Bit Cat is a playful meme coin with retro pixel charm. Simple, fun, and full of nostalgiajoin the 8-Bit Cat adventure today! Whether you're a cat lover or just love a good laugh, 8-Bit Cat is here to bring smiles. Hop on and watch this pixelated feline take over the meme coin world!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_1_23853a6c6a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BITCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BITCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

