module 0x8d75924711eb2f6561ebbf5c946a905b319f09574d4b1f90fd7c1786f469bdec::GUSD {
    struct GUSD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GUSD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GUSD>(arg0, 9, b"GUSD", b"GUSD", b"GUSD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUSD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GUSD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

