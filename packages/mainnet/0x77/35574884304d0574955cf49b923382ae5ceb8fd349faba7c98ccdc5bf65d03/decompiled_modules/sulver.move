module 0x7735574884304d0574955cf49b923382ae5ceb8fd349faba7c98ccdc5bf65d03::sulver {
    struct SULVER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SULVER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SULVER>(arg0, 6, b"SULVER", b"Sulver on Sui", b"Sulver is a parody of Silver the Hedgehog from the Sanic Hegehog series.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/coin_02_1024x981_b2604f4371.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SULVER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SULVER>>(v1);
    }

    // decompiled from Move bytecode v6
}

