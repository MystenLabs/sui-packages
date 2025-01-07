module 0x493b975f6dc5129ec20b48b2fe42be5b80ed621ac182f51b0bcd1d2185d85fd::blm {
    struct BLM has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLM>(arg0, 6, b"BLM", b"BLUM MEME", b"a meme da Exchange blum ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000345459_11e763a68f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLM>>(v1);
    }

    // decompiled from Move bytecode v6
}

