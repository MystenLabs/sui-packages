module 0x3c2d05dc28c22253a25d108f626411705285f4ad5cf253771f9f31d000c432da::slop {
    struct SLOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLOP>(arg0, 6, b"SLOP", b"Slop", b"inspired by $slop on solana blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000035968_fb34cf4006.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

