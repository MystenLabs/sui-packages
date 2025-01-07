module 0x52d1e17522c34755fccccc25dddac39804fce09fda73a8b12f4532f46b46d272::w8888 {
    struct W8888 has drop {
        dummy_field: bool,
    }

    fun init(arg0: W8888, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<W8888>(arg0, 6, b"W8888", b"Wbrain 8888", b"Wormy Brain 8888888888888888888888888888888888888888888888888888888888888", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3761b14cf1300058ebe88bf2b942723b_73f7a17a5c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<W8888>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<W8888>>(v1);
    }

    // decompiled from Move bytecode v6
}

