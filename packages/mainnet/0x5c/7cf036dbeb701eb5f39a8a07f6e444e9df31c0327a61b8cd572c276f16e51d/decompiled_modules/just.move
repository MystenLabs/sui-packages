module 0x5c7cf036dbeb701eb5f39a8a07f6e444e9df31c0327a61b8cd572c276f16e51d::just {
    struct JUST has drop {
        dummy_field: bool,
    }

    fun init(arg0: JUST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JUST>(arg0, 6, b"JUST", b"Just A Sui Token", b"Just pure meme madness and community love", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000091833_42c8aa7f35.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JUST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JUST>>(v1);
    }

    // decompiled from Move bytecode v6
}

