module 0x5af98e2f9a953087b6e71c237b87981a76b2e2efdf0873500bd0a37579541d85::mnrt {
    struct MNRT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MNRT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MNRT>(arg0, 6, b"MNRT", b"MOONRAT", b"MOONRAT ON SUI LFG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suirat_fd24af010e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MNRT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MNRT>>(v1);
    }

    // decompiled from Move bytecode v6
}

