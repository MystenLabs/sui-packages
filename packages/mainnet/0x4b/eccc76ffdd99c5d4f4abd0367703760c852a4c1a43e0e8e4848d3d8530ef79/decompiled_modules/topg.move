module 0x4beccc76ffdd99c5d4f4abd0367703760c852a4c1a43e0e8e4848d3d8530ef79::topg {
    struct TOPG has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOPG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOPG>(arg0, 6, b"TOPG", b"Tate Bros $TOPG", b"Whether you're trying to channel your inner Top G or just want a token that screams Im rich, and I know it, Tate Meme Token has got your back. With every transaction, youll feel like you're on the way to buy your 38th supercar while sipping on sparkling water", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://movepump.com/_next/image?url=https%3A%2F%2Fapi.movepump.com%2Fuploads%2FUntitled_design_6f9700afc2.jpg&w=640&q=75"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOPG>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TOPG>(&mut v2, 10000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOPG>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

