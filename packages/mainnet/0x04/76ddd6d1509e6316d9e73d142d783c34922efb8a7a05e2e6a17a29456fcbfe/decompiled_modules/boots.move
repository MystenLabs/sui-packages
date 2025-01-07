module 0x476ddd6d1509e6316d9e73d142d783c34922efb8a7a05e2e6a17a29456fcbfe::boots {
    struct BOOTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOTS>(arg0, 6, b"BOOTS", b"RED HOT CHILI BOOTS", b"Don't buy this token, I can take your money. only invest money you're willing to lose. DYOR.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/kandinsky_download_1694388470967_0642f05cf2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOOTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

