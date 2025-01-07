module 0x1ff3ea919371b6e486000541552e1d1c868bece03480821b4f36ee99fae73153::panthx {
    struct PANTHX has drop {
        dummy_field: bool,
    }

    fun init(arg0: PANTHX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PANTHX>(arg0, 6, b"PANTHX", b"Panth X", b"PanthX  The fiercest meme coin in the jungle!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000008968_892cee940f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PANTHX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PANTHX>>(v1);
    }

    // decompiled from Move bytecode v6
}

