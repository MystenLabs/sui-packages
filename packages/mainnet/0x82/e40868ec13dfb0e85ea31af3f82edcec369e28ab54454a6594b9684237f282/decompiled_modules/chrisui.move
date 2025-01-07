module 0x82e40868ec13dfb0e85ea31af3f82edcec369e28ab54454a6594b9684237f282::chrisui {
    struct CHRISUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHRISUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHRISUI>(arg0, 6, b"CHRISUI", b"Christmas Sui", b"Officially Launch", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Tanpa_judul_Konten_Instagram_75f8f3023c.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHRISUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHRISUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

