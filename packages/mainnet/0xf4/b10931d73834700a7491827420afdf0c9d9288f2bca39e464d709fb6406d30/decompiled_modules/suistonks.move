module 0xf4b10931d73834700a7491827420afdf0c9d9288f2bca39e464d709fb6406d30::suistonks {
    struct SUISTONKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISTONKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISTONKS>(arg0, 6, b"SuiStonks", b"Sui Stonks", b"SuiStonks is a memecoin inspired by the popular \"stonks\" meme, which humorously depicts investment successes and failures. The coin aims to blend humor with education in the crypto space, making it engaging for both seasoned traders and newcomers.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/94qyrc_399dba43c0.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISTONKS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISTONKS>>(v1);
    }

    // decompiled from Move bytecode v6
}

