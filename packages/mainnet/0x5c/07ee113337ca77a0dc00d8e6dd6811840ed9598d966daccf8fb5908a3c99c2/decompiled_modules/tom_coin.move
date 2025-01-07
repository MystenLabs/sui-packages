module 0x5c07ee113337ca77a0dc00d8e6dd6811840ed9598d966daccf8fb5908a3c99c2::tom_coin {
    struct TOM_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOM_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOM_COIN>(arg0, 9, b"TOM_COIN", b"Tom", b"Just for fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a56ac64b-84ef-4df9-85eb-6209e567f17e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOM_COIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOM_COIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

