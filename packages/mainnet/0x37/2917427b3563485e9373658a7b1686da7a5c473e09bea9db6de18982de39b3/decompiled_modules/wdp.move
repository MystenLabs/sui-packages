module 0x372917427b3563485e9373658a7b1686da7a5c473e09bea9db6de18982de39b3::wdp {
    struct WDP has drop {
        dummy_field: bool,
    }

    fun init(arg0: WDP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WDP>(arg0, 6, b"WDP", b"WAIRinDrop", b"Win Drop Air :D", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731254941955.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WDP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WDP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

