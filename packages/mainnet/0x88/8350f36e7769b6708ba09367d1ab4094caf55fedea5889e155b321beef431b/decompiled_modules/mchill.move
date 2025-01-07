module 0x888350f36e7769b6708ba09367d1ab4094caf55fedea5889e155b321beef431b::mchill {
    struct MCHILL has drop {
        dummy_field: bool,
    }

    fun init(arg0: MCHILL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MCHILL>(arg0, 6, b"MChill", b"Max Chill", b"Just a dude, chillin with a dude, disguised as another dude", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732253091475.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MCHILL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MCHILL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

