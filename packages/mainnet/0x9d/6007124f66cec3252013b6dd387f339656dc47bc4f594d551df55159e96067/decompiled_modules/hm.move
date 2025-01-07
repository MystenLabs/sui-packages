module 0x9d6007124f66cec3252013b6dd387f339656dc47bc4f594d551df55159e96067::hm {
    struct HM has drop {
        dummy_field: bool,
    }

    fun init(arg0: HM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HM>(arg0, 9, b"HM", b"Ha ma", x"48c3a0206dc3a3", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/27ceb18e-a1fd-4507-8c3e-385ba5c55a10.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HM>>(v1);
    }

    // decompiled from Move bytecode v6
}

