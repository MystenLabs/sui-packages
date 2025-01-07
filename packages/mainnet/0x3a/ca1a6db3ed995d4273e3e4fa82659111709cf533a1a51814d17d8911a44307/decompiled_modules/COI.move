module 0x3aca1a6db3ed995d4273e3e4fa82659111709cf533a1a51814d17d8911a44307::COI {
    struct COI has drop {
        dummy_field: bool,
    }

    fun init(arg0: COI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COI>(arg0, 9, b"TRUMP", b"Donald Trump", b"Donald Trump vs Putin", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<COI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

