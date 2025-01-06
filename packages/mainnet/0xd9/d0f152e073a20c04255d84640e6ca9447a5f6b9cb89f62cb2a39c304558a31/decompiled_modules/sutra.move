module 0xd9d0f152e073a20c04255d84640e6ca9447a5f6b9cb89f62cb2a39c304558a31::sutra {
    struct SUTRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUTRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUTRA>(arg0, 6, b"SUTRA", b"Sutra AI", b"Goddess of SuiNetwork", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1292_1f323cc773.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUTRA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUTRA>>(v1);
    }

    // decompiled from Move bytecode v6
}

