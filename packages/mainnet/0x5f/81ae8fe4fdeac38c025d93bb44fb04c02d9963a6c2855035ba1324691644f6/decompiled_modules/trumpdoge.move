module 0x5f81ae8fe4fdeac38c025d93bb44fb04c02d9963a6c2855035ba1324691644f6::trumpdoge {
    struct TRUMPDOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPDOGE>(arg0, 6, b"TrumpDoge", b"TRUMPDOGE", b"The two greatest memes in history unite to create the ultimate meme of all time: TrumpDoge on the Sui Chain! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0a053ad8_798a_4cc7_adf1_95becbb72123_1_1_1_1a4f471bd2.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPDOGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMPDOGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

