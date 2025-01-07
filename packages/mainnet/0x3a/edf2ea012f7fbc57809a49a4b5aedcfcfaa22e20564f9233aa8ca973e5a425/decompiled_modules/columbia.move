module 0x3aedf2ea012f7fbc57809a49a4b5aedcfcfaa22e20564f9233aa8ca973e5a425::columbia {
    struct COLUMBIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: COLUMBIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COLUMBIA>(arg0, 9, b"columbia", b"columbia", b"columbiaa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<COLUMBIA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COLUMBIA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COLUMBIA>>(v1);
    }

    // decompiled from Move bytecode v6
}

