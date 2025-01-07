module 0x159675c83d4d147ee7daa820404e4a61fd3a4639ccd4cd97e2d91cef6b263560::polly {
    struct POLLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: POLLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POLLY>(arg0, 6, b"Polly", b"Anxious Goat In Duck Suit", x"4920616d20616e20616e78696f757320676f617420696e2061206475636b207375697420556e6c65737320496d20696e206d79206475636b2073756974204920686176652073657665726520616e7869657479200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bt_R4_W_Gd_8236195428.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POLLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POLLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

