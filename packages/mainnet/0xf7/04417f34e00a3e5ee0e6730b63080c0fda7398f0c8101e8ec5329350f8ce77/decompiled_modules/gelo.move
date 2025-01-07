module 0xf704417f34e00a3e5ee0e6730b63080c0fda7398f0c8101e8ec5329350f8ce77::gelo {
    struct GELO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GELO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GELO>(arg0, 6, b"GELO", b"Sui Gelo", b"Just a little psycho chick on Sui blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_2024_10_10_T224129_231_b3b959b47d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GELO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GELO>>(v1);
    }

    // decompiled from Move bytecode v6
}

