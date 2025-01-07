module 0x2c2c73f05d40b62f1c31272139daf587bdc054914a4cc7b7011c668b2cdebca0::trf {
    struct TRF has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRF>(arg0, 9, b"TRF", b"Fboyoby", b"Tronton", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c9c11dcc-f109-458a-8614-e0623e343b3a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRF>>(v1);
    }

    // decompiled from Move bytecode v6
}

