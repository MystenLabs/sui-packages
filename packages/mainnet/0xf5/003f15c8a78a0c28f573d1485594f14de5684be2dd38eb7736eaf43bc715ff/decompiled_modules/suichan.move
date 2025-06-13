module 0xf5003f15c8a78a0c28f573d1485594f14de5684be2dd38eb7736eaf43bc715ff::suichan {
    struct SUICHAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICHAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICHAN>(arg0, 6, b"SUICHAN", b"SUINCHAN", x"245355494348414e20697320776861742068617070656e73207768656e20796f7572206368696c64686f6f64206c6f766520666f72205368696e6368616e20676574732067726f7720696e746f2074686520626c6f636b636861696e0a616e64207468656e206869747320746865206d617475726974792e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiedqeuwsxjdigvn5i6vln7vv36fkwzbuyaltpq67rcpbwpgyp2gui")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICHAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUICHAN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

