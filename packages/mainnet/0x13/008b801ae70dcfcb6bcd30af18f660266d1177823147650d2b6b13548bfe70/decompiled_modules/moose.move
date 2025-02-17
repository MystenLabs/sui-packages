module 0x13008b801ae70dcfcb6bcd30af18f660266d1177823147650d2b6b13548bfe70::moose {
    struct MOOSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOOSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOOSE>(arg0, 6, b"MOOSE", b"MOOSE On SUI", b"The only meme token with real utility.... Moose around and find out ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/mooselogo_4_d0a5d9e961.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOOSE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOOSE>>(v1);
    }

    // decompiled from Move bytecode v6
}

