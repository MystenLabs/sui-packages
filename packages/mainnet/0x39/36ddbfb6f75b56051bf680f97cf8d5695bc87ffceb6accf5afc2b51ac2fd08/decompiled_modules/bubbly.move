module 0x3936ddbfb6f75b56051bf680f97cf8d5695bc87ffceb6accf5afc2b51ac2fd08::bubbly {
    struct BUBBLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUBBLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUBBLY>(arg0, 6, b"BUBBLY", b"Bubbly", b"Bubbly, your Sui buddy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1301728833842_pic_31264bbabd_c6b2da6d60.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUBBLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUBBLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

