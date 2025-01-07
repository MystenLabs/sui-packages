module 0x73c26e74be60cf79dccb4c1dbdff3069fe083398438898843ef2f9b5969b413::rizzar {
    struct RIZZAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: RIZZAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RIZZAR>(arg0, 6, b"RIZZAR", b"Rizzard On Sui", b"We will bring miracles to the whole world", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241129_080947_960_1052bef080.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RIZZAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RIZZAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

