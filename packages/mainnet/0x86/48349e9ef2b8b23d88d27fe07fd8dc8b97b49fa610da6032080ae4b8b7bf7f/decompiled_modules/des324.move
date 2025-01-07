module 0x8648349e9ef2b8b23d88d27fe07fd8dc8b97b49fa610da6032080ae4b8b7bf7f::des324 {
    struct DES324 has drop {
        dummy_field: bool,
    }

    fun init(arg0: DES324, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DES324>(arg0, 6, b"DES324", b"DEs124", b"ttt", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cheems_meme_402c7ebf72.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DES324>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DES324>>(v1);
    }

    // decompiled from Move bytecode v6
}

