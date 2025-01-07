module 0x8ae44abb6a53e22e37e5941de887695261676dd79ce4cbb95557084a2906bc79::sheep {
    struct SHEEP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHEEP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHEEP>(arg0, 6, b"SHEEP", b"Black Sheep", b"Exile the shepherds follow the Black Sheep", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SHEEP_1f0d2d235a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHEEP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHEEP>>(v1);
    }

    // decompiled from Move bytecode v6
}

