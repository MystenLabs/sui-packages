module 0x7071c02345990ffd232f1f52118e394a03aa0eb2bc8cb7b26a9d554ea327903a::twif {
    struct TWIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: TWIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TWIF>(arg0, 6, b"Twif", b"Trumpwifdog", b"Trump wif American Eskimo dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5800_af1a074d97.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TWIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TWIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

