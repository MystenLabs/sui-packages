module 0x61079653297797e7e263ad2baa35a7abd829dac2904b0ec4fbad5dcef59d3643::dogeegod {
    struct DOGEEGOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGEEGOD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<DOGEEGOD>(arg0, 6, b"DOGEEGOD", b"dogeegod by SuiAI", b"dogeegod", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/dog_817de1d911.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DOGEEGOD>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGEEGOD>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

