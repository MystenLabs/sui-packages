module 0xcc61a8de3b4ffbf693c732337e007ec0c16b55951388ee3054b94ad50a8f13ff::atrtr {
    struct ATRTR has drop {
        dummy_field: bool,
    }

    fun init(arg0: ATRTR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ATRTR>(arg0, 9, b"ATRTR", b"gfg", b"45646", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/03969633-cb2d-4e77-90b4-8e6d0506aae7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ATRTR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ATRTR>>(v1);
    }

    // decompiled from Move bytecode v6
}

