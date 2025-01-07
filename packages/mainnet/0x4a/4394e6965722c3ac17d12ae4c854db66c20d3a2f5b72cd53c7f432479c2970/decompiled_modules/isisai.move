module 0x4a4394e6965722c3ac17d12ae4c854db66c20d3a2f5b72cd53c7f432479c2970::isisai {
    struct ISISAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ISISAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ISISAI>(arg0, 6, b"ISISAI", b"IRIS AI", b"Interactive Recursive Imagination System Gallery.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732548924211.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ISISAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ISISAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

