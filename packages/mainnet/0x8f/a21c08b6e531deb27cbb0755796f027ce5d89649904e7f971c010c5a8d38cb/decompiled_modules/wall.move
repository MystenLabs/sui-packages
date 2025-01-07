module 0x8fa21c08b6e531deb27cbb0755796f027ce5d89649904e7f971c010c5a8d38cb::wall {
    struct WALL has drop {
        dummy_field: bool,
    }

    fun init(arg0: WALL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WALL>(arg0, 6, b"WALL", b"Du Roves Wall", x"546865206d656d65636f696e2074686174206272696e6773206261636b0a6e6f7374616c67696120616e6420656e646c65737320766962657320696e737069726564206279207468650a47726561742057616c6c206f6620564b2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logowall_0284a04486.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WALL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WALL>>(v1);
    }

    // decompiled from Move bytecode v6
}

