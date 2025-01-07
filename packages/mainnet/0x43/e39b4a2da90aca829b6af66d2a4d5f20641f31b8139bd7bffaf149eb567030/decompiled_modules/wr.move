module 0x43e39b4a2da90aca829b6af66d2a4d5f20641f31b8139bd7bffaf149eb567030::wr {
    struct WR has drop {
        dummy_field: bool,
    }

    fun init(arg0: WR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WR>(arg0, 6, b"WR", b"We Robot", b"NEW AVATAR Elon Musk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/wer_fbe3813ab8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WR>>(v1);
    }

    // decompiled from Move bytecode v6
}

