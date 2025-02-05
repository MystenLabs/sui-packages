module 0x7c75a80bc569778f5a32e52bdce0edcd2d807194c69882ea8e19d39b7dd2f169::trm {
    struct TRM has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRM>(arg0, 9, b"TRM", b"TRUMP", b"aaaa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dev-file-walletapp.waveonsui.com/images/wave-pumps/bb50febe-836f-45fb-a8a8-50cf14b928c9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRM>>(v1);
    }

    // decompiled from Move bytecode v6
}

