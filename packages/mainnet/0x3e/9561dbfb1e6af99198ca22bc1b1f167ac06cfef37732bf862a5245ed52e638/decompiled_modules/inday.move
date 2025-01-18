module 0x3e9561dbfb1e6af99198ca22bc1b1f167ac06cfef37732bf862a5245ed52e638::inday {
    struct INDAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: INDAY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<INDAY>(arg0, 6, b"INDAY", b"Inauguration Day by SuiAI", b"The Inauguration Dai is a digital token created to mark historical and significant events, serving as a symbolic representation of commitment to innovation and digital transformation.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Inauguration_Day_250x250_1a07c74566.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<INDAY>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INDAY>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

