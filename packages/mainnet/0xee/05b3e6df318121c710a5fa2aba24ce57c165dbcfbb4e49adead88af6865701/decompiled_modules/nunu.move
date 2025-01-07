module 0xee05b3e6df318121c710a5fa2aba24ce57c165dbcfbb4e49adead88af6865701::nunu {
    struct NUNU has drop {
        dummy_field: bool,
    }

    fun init(arg0: NUNU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NUNU>(arg0, 6, b"NUNU", b"NUNU ON SUI", b"FIST MEME ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/9e09a86b3f7e2c0f6916190e7e44ec87_7c2d188498.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NUNU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NUNU>>(v1);
    }

    // decompiled from Move bytecode v6
}

