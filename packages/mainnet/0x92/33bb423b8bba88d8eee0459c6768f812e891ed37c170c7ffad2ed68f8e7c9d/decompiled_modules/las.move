module 0x9233bb423b8bba88d8eee0459c6768f812e891ed37c170c7ffad2ed68f8e7c9d::las {
    struct LAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAS>(arg0, 6, b"LAS", b"LIONMAS AI on SUI", x"204c494f4e4d41532041493a204120706f77657266756c20746f6b656e206275696c74206f6e205355492c2077697468206c6971756964697479206c6f636b6564207365637572656c792061667465722074686520626f6e64696e6720637572766520636f6d706c6574696f6e2e0a204a6f696e2075732061732077652067726f772c20696e6e6f766174652c20616e642064656c69766572206f6e206f75722070726f6d697365206f66206120646563656e7472616c697a65642c20636f6d6d756e6974792d64726976656e2065636f73797374656d21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3916_122523642e.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

