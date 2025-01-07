module 0x59237bc1a5d666eed3e7eebcb5c1aa608a4563570a0284fbef29c5af193f7371::blewmew {
    struct BLEWMEW has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLEWMEW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLEWMEW>(arg0, 6, b"Blewmew", b"Blewmew", b"Blewmew pair launch today", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.google.com/imgres?q=blewmew%20karikatur&imgurl=https%3A%2F%2Fpng.pngtree.com%2Fpng-vector%2F20230728%2Fourmid%2Fpngtree-blueberry-clipart-cute-blueberry-cartoon-character-vector-png-image_6796640.png&imgrefurl=https%3A%2F%2Fid.pngtree.com%2Ffree-png-vectors%2Fkartun-blueberry&docid=VlbnRnfdHu7ZIM&tbnid=5CCrqd3FYDfzeM&vet=12ahUKEwi3roDOkqKJAxVW1TgGHWg3GSUQM3oECGYQAA..i&w=360&h=360&hcb=2&ved=2ahUKEwi3roDOkqKJAxVW1TgGHWg3GSUQM3oECGYQAA")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BLEWMEW>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLEWMEW>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLEWMEW>>(v1);
    }

    // decompiled from Move bytecode v6
}

