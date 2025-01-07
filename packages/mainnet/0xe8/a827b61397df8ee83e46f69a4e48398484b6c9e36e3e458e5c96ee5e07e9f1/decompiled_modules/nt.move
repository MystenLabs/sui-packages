module 0xe8a827b61397df8ee83e46f69a4e48398484b6c9e36e3e458e5c96ee5e07e9f1::nt {
    struct NT has drop {
        dummy_field: bool,
    }

    fun init(arg0: NT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NT>(arg0, 6, b"Nt", b"nothing", b"nothing is everything", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6768_a055c617c9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NT>>(v1);
    }

    // decompiled from Move bytecode v6
}

