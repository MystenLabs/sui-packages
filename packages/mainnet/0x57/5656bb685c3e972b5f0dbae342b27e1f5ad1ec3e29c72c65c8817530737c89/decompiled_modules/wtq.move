module 0x575656bb685c3e972b5f0dbae342b27e1f5ad1ec3e29c72c65c8817530737c89::wtq {
    struct WTQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: WTQ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WTQ>(arg0, 6, b"WTQ", b"What The Quack!", x"576861742054686520517561636b210a517561636b2c517561636b2c517561636b21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5905_363dd14a2d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WTQ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WTQ>>(v1);
    }

    // decompiled from Move bytecode v6
}

