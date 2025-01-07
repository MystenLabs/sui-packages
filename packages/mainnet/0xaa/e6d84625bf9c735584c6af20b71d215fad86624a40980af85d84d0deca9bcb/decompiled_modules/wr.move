module 0xaae6d84625bf9c735584c6af20b71d215fad86624a40980af85d84d0deca9bcb::wr {
    struct WR has drop {
        dummy_field: bool,
    }

    fun init(arg0: WR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WR>(arg0, 6, b"Wr", b"We robot", b"We robot ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7132_7b1775a36c.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WR>>(v1);
    }

    // decompiled from Move bytecode v6
}

