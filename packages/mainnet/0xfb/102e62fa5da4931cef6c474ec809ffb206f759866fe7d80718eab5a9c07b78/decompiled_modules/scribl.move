module 0xfb102e62fa5da4931cef6c474ec809ffb206f759866fe7d80718eab5a9c07b78::scribl {
    struct SCRIBL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCRIBL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCRIBL>(arg0, 6, b"SCRIBL", b"Scribbles", b"Scribbles on the Sui network venturing to find their way to the ScribbleVerse  a world beyond the pages, where nothing is perfect, and creativity is endless", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/vision_f06e2083b1.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCRIBL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCRIBL>>(v1);
    }

    // decompiled from Move bytecode v6
}

