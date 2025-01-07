module 0xba8ff2a1342dda5791e6148ece8dac67c8886b0aa31b39f59ea0ebfa965d4273::trumpy {
    struct TRUMPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPY>(arg0, 6, b"TRUMPY", b"Trumpy No Dumpy", x"5452554d5059204e4f2044554d50592e20412063657274696669656420536e6f726b656c7a2062616e6765722e2057697468205472756d7079207468657265206973206e6f2064756d70792e204f6e6c792070756d70792e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Trumpy_ce4018c413.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

