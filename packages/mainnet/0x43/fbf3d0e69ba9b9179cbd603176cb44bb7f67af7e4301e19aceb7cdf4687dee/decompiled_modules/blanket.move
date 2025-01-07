module 0x43fbf3d0e69ba9b9179cbd603176cb44bb7f67af7e4301e19aceb7cdf4687dee::blanket {
    struct BLANKET has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLANKET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLANKET>(arg0, 6, b"BLANKET", b"Blanket Dog", b"Blanket - in cold weather we need a blanket to keep warm", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000008715_c971b94e1b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLANKET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLANKET>>(v1);
    }

    // decompiled from Move bytecode v6
}

