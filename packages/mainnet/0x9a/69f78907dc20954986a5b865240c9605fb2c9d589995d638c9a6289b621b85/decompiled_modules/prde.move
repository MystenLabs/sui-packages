module 0x9a69f78907dc20954986a5b865240c9605fb2c9d589995d638c9a6289b621b85::prde {
    struct PRDE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRDE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRDE>(arg0, 6, b"PRDE", b"Pawrade", b"Pawrade is a playful yet fiercely loyal community-driven project launching on Sui, designed to unleash the potential of blockchain in the most pawsome way. Every dip becomes a rally, and every holder becomes part of the parade.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734255976154.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PRDE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRDE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

