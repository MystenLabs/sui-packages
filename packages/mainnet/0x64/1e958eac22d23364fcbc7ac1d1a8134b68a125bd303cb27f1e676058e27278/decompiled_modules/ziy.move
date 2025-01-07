module 0x641e958eac22d23364fcbc7ac1d1a8134b68a125bd303cb27f1e676058e27278::ziy {
    struct ZIY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZIY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZIY>(arg0, 9, b"ZIY", b"Zaiyi", b"Ziytoken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d6adfed8-90bc-49ce-9e6a-e9d77ad31938.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZIY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZIY>>(v1);
    }

    // decompiled from Move bytecode v6
}

