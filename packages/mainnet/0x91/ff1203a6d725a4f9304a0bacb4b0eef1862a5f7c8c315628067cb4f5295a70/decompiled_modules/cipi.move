module 0x91ff1203a6d725a4f9304a0bacb4b0eef1862a5f7c8c315628067cb4f5295a70::cipi {
    struct CIPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CIPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CIPI>(arg0, 6, b"CIPI", b"CIPI CIPI CAPA CAPA", b"Chipi Chipi Chapa Chapa\" features cat meme all-star appearances with scenes of cats playing and dancing (but not all of them appear, so this is the first season)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cup_28b9a68e8d.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CIPI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CIPI>>(v1);
    }

    // decompiled from Move bytecode v6
}

