module 0xf68d3e7e4a2d27de638a10103655de865037eeeba6f6d3799a1210b747ab5e60::harm {
    struct HARM has drop {
        dummy_field: bool,
    }

    fun init(arg0: HARM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HARM>(arg0, 6, b"Harm", b"Harm Terminal", b"Harm Terminal is an experimental AI-powered interactive fiction platform where your choices shape the narrative through direct character interactions.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1739112067858.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HARM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HARM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

