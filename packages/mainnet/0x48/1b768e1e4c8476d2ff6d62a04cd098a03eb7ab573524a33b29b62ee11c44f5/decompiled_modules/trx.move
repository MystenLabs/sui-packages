module 0x481b768e1e4c8476d2ff6d62a04cd098a03eb7ab573524a33b29b62ee11c44f5::trx {
    struct TRX has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRX>(arg0, 9, b"TRX", b"Tronsui", b"Fake tron", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3a8e0c6c-2c23-477e-8f33-95fcc084fba2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRX>>(v1);
    }

    // decompiled from Move bytecode v6
}

