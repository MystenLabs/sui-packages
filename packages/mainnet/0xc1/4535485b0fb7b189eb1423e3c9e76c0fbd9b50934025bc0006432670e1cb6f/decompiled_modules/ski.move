module 0xc14535485b0fb7b189eb1423e3c9e76c0fbd9b50934025bc0006432670e1cb6f::ski {
    struct SKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKI>(arg0, 6, b"SKI", b"Ski mask dog", b"Masked dogs ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000003995_e7c4738f38.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

