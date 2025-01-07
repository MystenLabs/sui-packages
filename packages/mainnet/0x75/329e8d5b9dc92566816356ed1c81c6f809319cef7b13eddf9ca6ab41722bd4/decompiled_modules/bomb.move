module 0x75329e8d5b9dc92566816356ed1c81c6f809319cef7b13eddf9ca6ab41722bd4::bomb {
    struct BOMB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOMB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOMB>(arg0, 6, b"BOMB", b"BOMBSUI", b"WARTOBER IS HERE THE NEW MEME ON SUI IS HERE BOMBS ARE EXPENSIVE BOMBSUI IS READY FOR WAR ARE YOU BUY $BOMB TODAY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_1366_x_800_px_2_386d94c689.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOMB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOMB>>(v1);
    }

    // decompiled from Move bytecode v6
}

