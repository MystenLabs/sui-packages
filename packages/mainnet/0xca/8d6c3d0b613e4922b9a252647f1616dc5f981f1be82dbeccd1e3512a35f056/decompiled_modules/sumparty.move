module 0xca8d6c3d0b613e4922b9a252647f1616dc5f981f1be82dbeccd1e3512a35f056::sumparty {
    struct SUMPARTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUMPARTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUMPARTY>(arg0, 6, b"SumParty", b"Sui Meme Party", b"Welcome to the best meme party since the last memecoin season", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/smp_ea6268e399.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUMPARTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUMPARTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

