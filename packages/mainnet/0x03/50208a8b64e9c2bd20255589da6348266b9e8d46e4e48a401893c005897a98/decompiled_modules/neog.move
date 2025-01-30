module 0x350208a8b64e9c2bd20255589da6348266b9e8d46e4e48a401893c005897a98::neog {
    struct NEOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEOG>(arg0, 6, b"NeoG", b"Neocities Girl", b"Neocities Girl is an experimental AI-powered interactive fiction platform where your choices shape the narrative through direct character interactions.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2328_9c0a395d9f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

