module 0xc586ca458ef70b10e1d44c7cdfe56837def97062122fee17d53ba970e1c3ddb5::lfg {
    struct LFG has drop {
        dummy_field: bool,
    }

    fun init(arg0: LFG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LFG>(arg0, 6, b"LFG", b"LFG ", b"Lfg guys", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730959267578.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LFG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LFG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

