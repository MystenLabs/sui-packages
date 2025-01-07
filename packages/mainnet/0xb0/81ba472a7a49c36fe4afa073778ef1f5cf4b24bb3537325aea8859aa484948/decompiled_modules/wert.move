module 0xb081ba472a7a49c36fe4afa073778ef1f5cf4b24bb3537325aea8859aa484948::wert {
    struct WERT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WERT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WERT>(arg0, 9, b"WERT", b"RF", b"SF", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bf4a8311-5073-4738-a80e-68f5970e8b39.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WERT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WERT>>(v1);
    }

    // decompiled from Move bytecode v6
}

