module 0xd8f937ecc00639c66f8533e0310685de397473906b3bff2f3f11230d84475fd2::rex {
    struct REX has drop {
        dummy_field: bool,
    }

    fun init(arg0: REX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REX>(arg0, 6, b"REX", b"SUIREX", b"SUISAURUS REX OR SUIREX IS CUTE, FUN-LOVING, DINO ON THE SUI BLOCKCHAIN. HE DOESN'T STAY CUTE AND SMALL FOREVER THOUGH. SUIREX GROWS, AND HE GROWS FAST. NOBODY HAS EVER SEEN JUST HOW BIG REX CAN GROW, WHICH BEGS THE QUESTION. JUST HOW BIG CAN HE GET?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suirex_812076fc43.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<REX>>(v1);
    }

    // decompiled from Move bytecode v6
}

