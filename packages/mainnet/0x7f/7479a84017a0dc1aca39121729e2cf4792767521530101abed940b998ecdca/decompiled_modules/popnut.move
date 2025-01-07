module 0x7f7479a84017a0dc1aca39121729e2cf4792767521530101abed940b998ecdca::popnut {
    struct POPNUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPNUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPNUT>(arg0, 6, b"POPNUT", b"Pop Peanut On Sui", b"POPNUT is a meme token featuring a quirky squirrel named Peanut.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/POPPNUT_ICON_X_300x300_872d6f27e0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPNUT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POPNUT>>(v1);
    }

    // decompiled from Move bytecode v6
}

