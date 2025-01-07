module 0xf107b0b1e3dde7fbf42882e06331d5ecc27940cf4bbb4f1890e718a526983e8c::kickoff {
    struct KICKOFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: KICKOFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KICKOFF>(arg0, 6, b"Kickoff", b"Kick", x"546f20746872206d6f6f6e206c696b65206b69636b0a4e6f206d6f7265", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000046168_e1f4c74508.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KICKOFF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KICKOFF>>(v1);
    }

    // decompiled from Move bytecode v6
}

