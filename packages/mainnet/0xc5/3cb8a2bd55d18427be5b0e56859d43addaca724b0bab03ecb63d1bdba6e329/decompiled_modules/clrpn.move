module 0xc53cb8a2bd55d18427be5b0e56859d43addaca724b0bab03ecb63d1bdba6e329::clrpn {
    struct CLRPN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLRPN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLRPN>(arg0, 9, b"CLRPN", b"color", b"Color your crypto journey with Colored Pencil", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e3382999-ee0c-4051-b7d2-f3082a67edc9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLRPN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CLRPN>>(v1);
    }

    // decompiled from Move bytecode v6
}

