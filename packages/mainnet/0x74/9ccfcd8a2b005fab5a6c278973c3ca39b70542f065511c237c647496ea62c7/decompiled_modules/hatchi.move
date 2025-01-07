module 0x749ccfcd8a2b005fab5a6c278973c3ca39b70542f065511c237c647496ea62c7::hatchi {
    struct HATCHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HATCHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HATCHI>(arg0, 6, b"HATCHI", b"HACHIKO Token", b"No. 1 Meme Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Hachiko_6e3d45c2c1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HATCHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HATCHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

