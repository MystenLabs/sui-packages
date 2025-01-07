module 0x3dbbc45217a9a6c4a83c287e71278b373d4504831d66d8a6e1eab067e29426a1::trenrat {
    struct TRENRAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRENRAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRENRAT>(arg0, 6, b"TRENRAT", b"Tren Rat", b"IRL ExperimentalRat on Steroids, injecting  trenbolone & masteron, Scientific Roadmap, livestream on movepum & telegram ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250103_023733_344_808bd2a638.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRENRAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRENRAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

