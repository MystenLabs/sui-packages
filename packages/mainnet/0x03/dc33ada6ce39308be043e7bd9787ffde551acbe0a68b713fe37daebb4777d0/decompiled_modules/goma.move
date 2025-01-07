module 0x3dc33ada6ce39308be043e7bd9787ffde551acbe0a68b713fe37daebb4777d0::goma {
    struct GOMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOMA>(arg0, 6, b"Goma", b"Goatsuyi Maximuis", b"Goatsui will rise to fulfill the prophecies of the ancient meme-lords.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/gsyi_d68afd47ed.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

