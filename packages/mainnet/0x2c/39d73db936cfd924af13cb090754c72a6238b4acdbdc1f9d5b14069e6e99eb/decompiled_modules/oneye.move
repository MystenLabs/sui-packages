module 0x2c39d73db936cfd924af13cb090754c72a6238b4acdbdc1f9d5b14069e6e99eb::oneye {
    struct ONEYE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ONEYE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ONEYE>(arg0, 9, b"ONEYE", b"Zuka", b"Zuko the famous shiba inu with one eye.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9814ca40-9059-40f8-8b25-c51b6e5d2b18.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ONEYE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ONEYE>>(v1);
    }

    // decompiled from Move bytecode v6
}

