module 0x641b13e94b4045082bb814ca82393b28a411cceaabaa348ce2e0a6fb1057461a::hnt {
    struct HNT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HNT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HNT>(arg0, 9, b"HNT", b"Hunter", b"Hunt the token . Hunt the money", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6c431b95-96b9-4a5a-b5b3-40b80021d47e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HNT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HNT>>(v1);
    }

    // decompiled from Move bytecode v6
}

