module 0x7b7c5d947b03ea33870490bf629a71186cd8e2593b47ee61ace835aea4db6230::sfish {
    struct SFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFISH>(arg0, 6, b"Sfish", b"Sui fish", b"Don't sell ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241018_203203_2db3ee52e8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

