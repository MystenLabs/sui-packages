module 0xc40fb484b884d91ac52453a3cfeb587ff4474b9a3cd3c235ec9610efa67f65d7::dogesui {
    struct DOGESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGESUI>(arg0, 6, b"DogeSUI", b"Doge SUI", b"So SUI. Much water. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/doge_e0bf60ce59.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGESUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGESUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

