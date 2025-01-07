module 0x1e1addc8b5864bb05a7a45c7183a235ce7b799f8a8dcfa367149113d03b02987::gerry {
    struct GERRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GERRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GERRY>(arg0, 6, b"GERRY", b"GERRYSUI", b"Gerrysui is a snail and SpongeBob SquarePants's pet. He usually can only say, \"Meow\", while sea worms in the show bark, which indicates that snails are the ocean equivalent of cats and worms are dogs. In some episodes, Gary has said something other than \"meow\" but this is rare.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/LOGO_01a6b2bcdc.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GERRY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GERRY>>(v1);
    }

    // decompiled from Move bytecode v6
}

