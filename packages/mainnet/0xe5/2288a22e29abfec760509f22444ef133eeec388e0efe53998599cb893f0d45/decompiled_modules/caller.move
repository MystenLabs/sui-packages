module 0xe52288a22e29abfec760509f22444ef133eeec388e0efe53998599cb893f0d45::caller {
    struct CALLER has drop {
        dummy_field: bool,
    }

    fun init(arg0: CALLER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CALLER>(arg0, 6, b"CALLER", b"The Caller On Sui", b"In a world where the market seems uncontrollable, the Caller is the only one who can save it and turn the tide. He is the one who picks up the phone and declares: PUMP IT or DUMP ITand makes the jeets cry while were at it. Everything moves at your command, and the jeets wont know what hit them. Is it time for a call?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/portal_1b93726b0f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CALLER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CALLER>>(v1);
    }

    // decompiled from Move bytecode v6
}

