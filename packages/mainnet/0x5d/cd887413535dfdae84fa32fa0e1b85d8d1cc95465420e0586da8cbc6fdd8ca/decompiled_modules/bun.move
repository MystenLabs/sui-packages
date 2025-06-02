module 0x5dcd887413535dfdae84fa32fa0e1b85d8d1cc95465420e0586da8cbc6fdd8ca::bun {
    struct BUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUN>(arg0, 6, b"BUN", b"SuiBun", x"53756942756e2069736e74206a75737420612062756e6e792e0a48652069732074686520666173746573742072756e6e6572206f6e207468652053756920626c6f636b636861696e2c20686f7070696e672066726f6d20626c6f636b20746f20626c6f636b20776974682073706565642c20636861726d2c20616e642070757265206d656d6520656e657267792e0a0a466173742e20437574652e20556e73746f707061626c652e0a0a52756e20776974682053756942756e206f7220676574206c65667420626568696e642e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreieapnbvjuikbdxhuwn3jcfso3odoi6es7a6c3kaohveokpme2v3ya")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BUN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

