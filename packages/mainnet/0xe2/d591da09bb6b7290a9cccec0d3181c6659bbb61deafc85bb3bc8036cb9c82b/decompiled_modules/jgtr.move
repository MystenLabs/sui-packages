module 0xe2d591da09bb6b7290a9cccec0d3181c6659bbb61deafc85bb3bc8036cb9c82b::jgtr {
    struct JGTR has drop {
        dummy_field: bool,
    }

    fun init(arg0: JGTR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JGTR>(arg0, 9, b"JGTR", b"Jugator ", b"Only real Jugators can understand each other ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f03b3014-d95e-43e3-b8aa-ed4a1001648a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JGTR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JGTR>>(v1);
    }

    // decompiled from Move bytecode v6
}

