module 0x6e76fb9498b1a7225ddbcca2ab0b7eacb0644c5603e7f93a92650c204a253f0f::w {
    struct W has drop {
        dummy_field: bool,
    }

    fun init(arg0: W, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<W>(arg0, 6, b"W", b"Elon W", b"When it comes to Elon we make W's ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Elon_W_e3481c0c98.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<W>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<W>>(v1);
    }

    // decompiled from Move bytecode v6
}

