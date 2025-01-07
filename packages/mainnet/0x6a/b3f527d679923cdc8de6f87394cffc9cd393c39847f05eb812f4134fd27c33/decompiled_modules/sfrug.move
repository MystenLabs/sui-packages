module 0x6ab3f527d679923cdc8de6f87394cffc9cd393c39847f05eb812f4134fd27c33::sfrug {
    struct SFRUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFRUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFRUG>(arg0, 6, b"SFRUG", b"SUIFRUG", b"SFRUG catch no pumps. SFRUG never stop pumpin.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0x11135ab31832f73fb007b5a55b630e6438817b24521af4bd4274537cd02e433d_frug_frug_ccb1f0bbf1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFRUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SFRUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

