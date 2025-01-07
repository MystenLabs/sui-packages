module 0xa35638050fce509de7811f5175c7ba2f9964cec2d8c808bd61a5ef449b8a14a8::decry {
    struct DECRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DECRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DECRY>(arg0, 9, b"DECRY", b"De cryp", b"Community token ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6d363fbb-e8df-4f3f-8b57-3090cff44246.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DECRY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DECRY>>(v1);
    }

    // decompiled from Move bytecode v6
}

