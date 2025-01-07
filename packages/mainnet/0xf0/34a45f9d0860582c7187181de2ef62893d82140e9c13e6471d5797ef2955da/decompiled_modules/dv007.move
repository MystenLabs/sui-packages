module 0xf034a45f9d0860582c7187181de2ef62893d82140e9c13e6471d5797ef2955da::dv007 {
    struct DV007 has drop {
        dummy_field: bool,
    }

    fun init(arg0: DV007, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DV007>(arg0, 9, b"DV007", b"dienvien", b"aaaaaa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/07b6041b-9989-4870-a4c2-7c3c5421a85f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DV007>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DV007>>(v1);
    }

    // decompiled from Move bytecode v6
}

