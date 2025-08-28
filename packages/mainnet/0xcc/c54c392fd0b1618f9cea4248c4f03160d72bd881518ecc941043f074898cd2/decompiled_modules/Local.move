module 0xccc54c392fd0b1618f9cea4248c4f03160d72bd881518ecc941043f074898cd2::Local {
    struct LOCAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOCAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOCAL>(arg0, 9, b"SPACE", b"Local", b"local spaceship", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/media/GzW8I3CXgAAUuLD?format=jpg&name=medium")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LOCAL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOCAL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

