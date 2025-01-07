module 0x4a2b80419c48fbe2a17b847d07f57747dea4556c63f1cead127ad1a8b138b4b0::aaahat {
    struct AAAHAT has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<AAAHAT>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<AAAHAT>>(0x2::coin::mint<AAAHAT>(arg0, arg2 * 1000000000, arg3), arg1);
    }

    fun init(arg0: AAAHAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAHAT>(arg0, 9, b"AAAH", b"AAAHAT", b"Wont stop thinking about sui,,,AAAHAT style!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1781562232964587520/jwnE16ru_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AAAHAT>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AAAHAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAHAT>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

