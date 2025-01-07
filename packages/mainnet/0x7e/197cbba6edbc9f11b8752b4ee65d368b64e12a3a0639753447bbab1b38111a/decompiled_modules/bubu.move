module 0x7e197cbba6edbc9f11b8752b4ee65d368b64e12a3a0639753447bbab1b38111a::bubu {
    struct BUBU has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUBU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUBU>(arg0, 9, b"BUBU", b"bubu token", b"bubu token by mitha ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/aa22f6ce-9492-4128-89be-93a58c8cb980.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUBU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BUBU>>(v1);
    }

    // decompiled from Move bytecode v6
}

