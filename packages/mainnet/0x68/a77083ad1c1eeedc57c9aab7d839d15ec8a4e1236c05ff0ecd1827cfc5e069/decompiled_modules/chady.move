module 0x68a77083ad1c1eeedc57c9aab7d839d15ec8a4e1236c05ff0ecd1827cfc5e069::chady {
    struct CHADY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHADY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHADY>(arg0, 6, b"CHADY", b"CHADYPEPE", b"CHADY meme for man", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/8png_1024x1024_ce39465db3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHADY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHADY>>(v1);
    }

    // decompiled from Move bytecode v6
}

