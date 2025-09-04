module 0x2e9e706bb2cd2f65f22688fa71ab5a9659b838bbbb47d7e708b2dd4fc098111c::The_Dumbos {
    struct THE_DUMBOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: THE_DUMBOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THE_DUMBOS>(arg0, 9, b"DUMBOS", b"The Dumbos", b"tweedle dumb tweedle dee. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/media/Gz985UhXcAA-cLj?format=jpg&name=large")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<THE_DUMBOS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THE_DUMBOS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

