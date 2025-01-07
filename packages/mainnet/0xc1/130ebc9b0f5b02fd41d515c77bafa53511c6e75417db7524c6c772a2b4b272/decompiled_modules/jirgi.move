module 0xc1130ebc9b0f5b02fd41d515c77bafa53511c6e75417db7524c6c772a2b4b272::jirgi {
    struct JIRGI has drop {
        dummy_field: bool,
    }

    fun init(arg0: JIRGI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JIRGI>(arg0, 9, b"JIRGI", b"Ak", b"Crypto token for trading ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1573bc77-94d4-4f50-9fa7-9118249863cd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JIRGI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JIRGI>>(v1);
    }

    // decompiled from Move bytecode v6
}

