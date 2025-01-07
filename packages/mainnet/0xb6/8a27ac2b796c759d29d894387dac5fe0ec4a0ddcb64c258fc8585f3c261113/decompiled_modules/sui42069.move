module 0xb68a27ac2b796c759d29d894387dac5fe0ec4a0ddcb64c258fc8585f3c261113::sui42069 {
    struct SUI42069 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI42069, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI42069>(arg0, 6, b"Sui42069", b"42069", b"Nice one.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/42069_Twitter_PFP_c42f2fa2d7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI42069>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUI42069>>(v1);
    }

    // decompiled from Move bytecode v6
}

