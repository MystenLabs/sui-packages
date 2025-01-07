module 0xfff983e3493420b7d72df0ff6aeab365ba5eb7cf87e56e078f5a925b25b599c2::zaxa {
    struct ZAXA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZAXA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZAXA>(arg0, 9, b"ZAXA", b"ZAXA VAU", b"TEAM WORK IS THE KEY ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/42ad0417-23b6-4608-aff1-269006fb9499.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZAXA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZAXA>>(v1);
    }

    // decompiled from Move bytecode v6
}

