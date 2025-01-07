module 0xb6b8ab87657c026d3e5f9d7aa959f9f1bd6481e4647f2cc5be60b31f387dcce8::amigoscoin {
    struct AMIGOSCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: AMIGOSCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AMIGOSCOIN>(arg0, 6, b"Amigoscoin", b"amigos", b"I'm back and I'm the strongest meme ever", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730997087116.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AMIGOSCOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AMIGOSCOIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

