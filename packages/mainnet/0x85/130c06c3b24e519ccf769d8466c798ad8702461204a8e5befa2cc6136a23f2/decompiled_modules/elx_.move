module 0x85130c06c3b24e519ccf769d8466c798ad8702461204a8e5befa2cc6136a23f2::elx_ {
    struct ELX_ has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELX_, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELX_>(arg0, 9, b"ELX_", b"elonx", b"elon fan token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/855d82cb-b040-4120-a028-1f1fc9054199.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELX_>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ELX_>>(v1);
    }

    // decompiled from Move bytecode v6
}

