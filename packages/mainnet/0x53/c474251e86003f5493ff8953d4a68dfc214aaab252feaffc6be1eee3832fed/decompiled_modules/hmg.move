module 0x53c474251e86003f5493ff8953d4a68dfc214aaab252feaffc6be1eee3832fed::hmg {
    struct HMG has drop {
        dummy_field: bool,
    }

    fun init(arg0: HMG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HMG>(arg0, 9, b"HMG", x"484d47f09faab7", b"HMG flower in VN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/99ab8d87-e8ae-45f5-a467-76a60dde8c06.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HMG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HMG>>(v1);
    }

    // decompiled from Move bytecode v6
}

