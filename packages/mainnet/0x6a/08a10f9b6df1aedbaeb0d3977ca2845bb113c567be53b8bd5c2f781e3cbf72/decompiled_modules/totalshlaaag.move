module 0x6a08a10f9b6df1aedbaeb0d3977ca2845bb113c567be53b8bd5c2f781e3cbf72::totalshlaaag {
    struct TOTALSHLAAAG has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOTALSHLAAAG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOTALSHLAAAG>(arg0, 9, b"TOTAL SHLAAAG", b"TOTALSHLAG", b"I'm not just a slag...I'm a TOTAL SHLAAAG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://res.cloudinary.com/ddjudhfru/image/upload/v1759938988/sui_tokens/ixib8hx0yati4csm94ru.jpg"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<TOTALSHLAAAG>>(0x2::coin::mint<TOTALSHLAAAG>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TOTALSHLAAAG>>(v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TOTALSHLAAAG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

