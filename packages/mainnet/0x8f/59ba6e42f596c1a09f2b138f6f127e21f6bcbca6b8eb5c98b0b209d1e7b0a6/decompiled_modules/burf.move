module 0x8f59ba6e42f596c1a09f2b138f6f127e21f6bcbca6b8eb5c98b0b209d1e7b0a6::burf {
    struct BURF has drop {
        dummy_field: bool,
    }

    fun init(arg0: BURF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BURF>(arg0, 6, b"BURF", b"Surfing bull", b"This bull is bullish for the next set", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5895_78cd423b35.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BURF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BURF>>(v1);
    }

    // decompiled from Move bytecode v6
}

