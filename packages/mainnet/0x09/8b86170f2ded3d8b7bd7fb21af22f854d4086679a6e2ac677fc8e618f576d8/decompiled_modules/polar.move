module 0x98b86170f2ded3d8b7bd7fb21af22f854d4086679a6e2ac677fc8e618f576d8::polar {
    struct POLAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: POLAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POLAR>(arg0, 6, b"POLAR", b"Polar ON SUI", b"Experience the future of crypto with $POLAR Sui, the premium memecoin for the discerning investor.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731771048192.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POLAR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POLAR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

