module 0x455db29ce1fcafc2c2c6558f8d55973b8f73f925201dd7ea9d096ef4586c85df::frug {
    struct FRUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRUG>(arg0, 6, b"FRUG", b"FRUG SUI", b"This is $FRUG. He is professional frog, has all the sthrengths and no weakness. Have a deal now.  ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_05_17_57_53_ae96498d5a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FRUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

