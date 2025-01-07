module 0xac138bed204c7fd330fe28dcff36a212911b40cbb7226b0b585156ea080edd41::tmaga {
    struct TMAGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TMAGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TMAGA>(arg0, 6, b"TMAGA", b"Trump MAGA", b"TMAGA - Trump MAGA is the newly SUI meme coin developed to support Donald Trump ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1723289342374_4bc94fd86950f2547b46d3805d78272c_a861f91dea.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TMAGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TMAGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

