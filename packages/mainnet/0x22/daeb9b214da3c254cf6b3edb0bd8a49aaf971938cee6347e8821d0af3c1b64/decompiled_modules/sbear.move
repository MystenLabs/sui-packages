module 0x22daeb9b214da3c254cf6b3edb0bd8a49aaf971938cee6347e8821d0af3c1b64::sbear {
    struct SBEAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBEAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBEAR>(arg0, 9, b"SBEAR", b"BEAR", b"SBEAAR", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b3c51164-1348-4ad4-b0a5-cae7a4b3f0b0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBEAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SBEAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

