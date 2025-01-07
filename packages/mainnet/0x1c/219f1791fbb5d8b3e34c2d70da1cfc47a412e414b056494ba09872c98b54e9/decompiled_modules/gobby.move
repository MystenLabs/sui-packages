module 0x1c219f1791fbb5d8b3e34c2d70da1cfc47a412e414b056494ba09872c98b54e9::gobby {
    struct GOBBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOBBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOBBY>(arg0, 6, b"GOBBY", b"Gobby Sui", x"476f62627920697320616e206f726967696e616c0a636861726163746572206261736564206f6666206f6620610a64726177696e67206279206d6174742066757269652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000002926_7f7abcba10.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOBBY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOBBY>>(v1);
    }

    // decompiled from Move bytecode v6
}

