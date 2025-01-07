module 0x542f3779a18b7a33652b5e1e5942af140ff216fff6d32da7f92b5cbc63e8c723::bgrok {
    struct BGROK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BGROK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BGROK>(arg0, 6, b"BGrok", b"Baby Gron On Sui", x"426162792047726f6b206e65772032303235206d656d6520746f6b656e0a0a68747470733a2f2f742e6d652f6261627967726f6b4f6e737569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4871_3879610925.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BGROK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BGROK>>(v1);
    }

    // decompiled from Move bytecode v6
}

