module 0x4e5132ffd9dea11715dbe5a9814b4c5011a938f3f1b0091b30b2c6d0604cb5f7::hanbao {
    struct HANBAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HANBAO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HANBAO>(arg0, 6, b"Hanbao", b"Hanbao on sui", b"Hanbao the smiling Dolphin ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1982_ce31254ca0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HANBAO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HANBAO>>(v1);
    }

    // decompiled from Move bytecode v6
}

