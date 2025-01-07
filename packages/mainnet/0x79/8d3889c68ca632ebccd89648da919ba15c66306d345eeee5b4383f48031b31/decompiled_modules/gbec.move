module 0x798d3889c68ca632ebccd89648da919ba15c66306d345eeee5b4383f48031b31::gbec {
    struct GBEC has drop {
        dummy_field: bool,
    }

    fun init(arg0: GBEC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GBEC>(arg0, 6, b"GBEC", b"Green Blue Eyed Cat", b"Green and blue laser eyed - cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_11_164425_01c0facf07.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GBEC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GBEC>>(v1);
    }

    // decompiled from Move bytecode v6
}

