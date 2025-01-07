module 0xcf17e667f68fb95ffdca37c62404e14de5598f8aa8ff2fa2285740d570276d05::chg {
    struct CHG has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHG>(arg0, 9, b"CHG", b"Chigga", x"43686967676120e698afe69da5e887aae4b8ade59bbde79a84e5838fe7b4a0e6a8a1e59ba0", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0f876114-e17b-4530-bec0-9f71235c1eb0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHG>>(v1);
    }

    // decompiled from Move bytecode v6
}

