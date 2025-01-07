module 0x31d73354819b4bf04b50d57636bb81db71ddc16878ca006aa940fc22509da5b1::fuzzy {
    struct FUZZY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUZZY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUZZY>(arg0, 9, b"FUZZY", b"Fuzzy Squid", b"FUZZY FUZZY FUZZY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1527297443859050497/K_lLy0RS.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FUZZY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUZZY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUZZY>>(v1);
    }

    // decompiled from Move bytecode v6
}

