module 0x2a63edb2cdfcb87ce3f0be8eb5e2b7fe72046e421b1c59f2f94dc6cdd79541ee::dum {
    struct DUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUM>(arg0, 9, b"DUM", b"Dumb degen", b"Degens are awesome but some are dumb", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2352f372-9f7d-44d3-ab0c-eb5cba7dc3ef.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DUM>>(v1);
    }

    // decompiled from Move bytecode v6
}

