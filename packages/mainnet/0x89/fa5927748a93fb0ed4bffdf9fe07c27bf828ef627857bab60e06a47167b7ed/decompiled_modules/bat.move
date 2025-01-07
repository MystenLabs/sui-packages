module 0x89fa5927748a93fb0ed4bffdf9fe07c27bf828ef627857bab60e06a47167b7ed::bat {
    struct BAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAT>(arg0, 6, b"BAT", b"Sui Bat", b"Sui $BAT is here to take flight. Lets get batty with it! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Bat_bc0bdc564e.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

