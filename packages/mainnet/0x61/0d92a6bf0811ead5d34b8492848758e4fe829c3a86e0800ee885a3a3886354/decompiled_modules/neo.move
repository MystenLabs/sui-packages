module 0x610d92a6bf0811ead5d34b8492848758e4fe829c3a86e0800ee885a3a3886354::neo {
    struct NEO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEO>(arg0, 6, b"NEO", b"neo cat", b"Neo is a very adorable cat. This is a character that can succeed on Sui Network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/neogif250_f6eba1a90f.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEO>>(v1);
    }

    // decompiled from Move bytecode v6
}

