module 0x314424fcd821b363f0477fbdda8d4fd258a463de55412820c07cba30a70e611d::dolf {
    struct DOLF has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOLF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOLF>(arg0, 6, b"DOLF", b"Dolf", b"DOLF is a young and charming dolphin that confidently surfs through the chaos of meme coins, becoming the ultimate icon of the SUI ocean!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://movepump.com/_next/image?url=https%3A%2F%2Fapi.movepump.com%2Fuploads%2FResized_Dolf_b343998bd8.png&w=640&q=75"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOLF>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DOLF>(&mut v2, 10000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOLF>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

