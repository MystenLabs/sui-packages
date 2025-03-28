module 0x8ebcd1ba71b8a6192251b87de79f57c4fa36e260efa74ad638fee2f090bea028::panty {
    struct PANTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PANTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PANTY>(arg0, 9, b"PANTY", b"Panty the Pussycat", b"Panty has ventured into the land of SUI.  Is she now Panty the PuSuiCat?  Maybe!  Come join her and have fun and you'll soon be panting too!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/788bba9a1d3c599822f202ff94e46a7bblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PANTY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PANTY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

