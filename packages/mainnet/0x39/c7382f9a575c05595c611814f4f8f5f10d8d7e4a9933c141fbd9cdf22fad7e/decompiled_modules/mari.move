module 0x39c7382f9a575c05595c611814f4f8f5f10d8d7e4a9933c141fbd9cdf22fad7e::mari {
    struct MARI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MARI>(arg0, 6, b"MARI", b"MARI on SUI", b"Launching the new Mari on SUI, Fantoms Mari big brother!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0969_0811154d15.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MARI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MARI>>(v1);
    }

    // decompiled from Move bytecode v6
}

