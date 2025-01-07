module 0xd6231a1dbd5e724aa1f45401000bb3b1898bedfe6a43895f6c4d619c9e19f5fc::doraemoon {
    struct DORAEMOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: DORAEMOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DORAEMOON>(arg0, 6, b"Doraemoon", b"DORAEMOON", b"Doraemon is the classic series of your and everyone's childhood. Can you think of anything else bullish?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/Captura_de_pantalla_2024_09_24_204121_ba02c27726.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DORAEMOON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DORAEMOON>>(v1);
    }

    // decompiled from Move bytecode v6
}

