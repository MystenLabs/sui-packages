module 0x5f5bf548d1418b6914b7773795a832bcfe1174b3cf7dcfe3d3aff6453510705a::buttsui {
    struct BUTTSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUTTSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUTTSUI>(arg0, 6, b"ButtSui", b"ButtSui Coin", b"Butters missed BTC - and now they earn us lambos. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1781_86a7bc9fbd.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUTTSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUTTSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

