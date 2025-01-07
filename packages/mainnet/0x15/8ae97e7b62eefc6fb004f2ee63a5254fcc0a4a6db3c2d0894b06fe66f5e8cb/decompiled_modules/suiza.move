module 0x158ae97e7b62eefc6fb004f2ee63a5254fcc0a4a6db3c2d0894b06fe66f5e8cb::suiza {
    struct SUIZA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIZA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIZA>(arg0, 6, b"SUIza", b"Suiza", b"First token inspired by Switzerland, a country that supports crypto", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sui_za_c1c34494e4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIZA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIZA>>(v1);
    }

    // decompiled from Move bytecode v6
}

