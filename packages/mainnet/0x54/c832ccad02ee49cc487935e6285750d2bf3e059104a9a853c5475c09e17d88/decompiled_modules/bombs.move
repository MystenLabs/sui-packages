module 0x54c832ccad02ee49cc487935e6285750d2bf3e059104a9a853c5475c09e17d88::bombs {
    struct BOMBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOMBS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOMBS>(arg0, 6, b"BOMBS", b"BOMBSUI", b"WARTOBER IS HERE THE NEW MEME ON SUI IS HERE BOMBS ARE EXPENSIVE BOMBSUI IS READY FOR WAR ARE YOU BUY $BOMB TODAY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_1366_x_800_px_2_386d94c689_48e69aa96f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOMBS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOMBS>>(v1);
    }

    // decompiled from Move bytecode v6
}

