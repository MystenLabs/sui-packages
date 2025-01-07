module 0x7cbce143a468180cb05ceff3abeb9f986a05bbfb4934a95e3fdfc67352906f7b::diene {
    struct DIENE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIENE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIENE>(arg0, 9, b"DIENE", b"hdnd", b"jdjd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/70561eb1-abb5-4eaa-8606-ee97e0df30ca.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIENE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DIENE>>(v1);
    }

    // decompiled from Move bytecode v6
}

