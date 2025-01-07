module 0x980b20a4beb82e35784e0e8ceaba1b76ee1b5d968687ac137ba2496edafe483e::yum {
    struct YUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: YUM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YUM>(arg0, 6, b"YUM", b"Yummy", b"Yummy the biggest community meme coin to be birthed. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7056_9fe85569f8.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YUM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YUM>>(v1);
    }

    // decompiled from Move bytecode v6
}

