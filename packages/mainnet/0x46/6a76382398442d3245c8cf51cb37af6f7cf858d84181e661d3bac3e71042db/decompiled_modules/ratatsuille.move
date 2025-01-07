module 0x466a76382398442d3245c8cf51cb37af6f7cf858d84181e661d3bac3e71042db::ratatsuille {
    struct RATATSUILLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: RATATSUILLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RATATSUILLE>(arg0, 6, b"RATATSUILLE", b"RataSuille on SUI", b"THE CHEF OF SUI NETWORK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ratasui_3c98c582fc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RATATSUILLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RATATSUILLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

