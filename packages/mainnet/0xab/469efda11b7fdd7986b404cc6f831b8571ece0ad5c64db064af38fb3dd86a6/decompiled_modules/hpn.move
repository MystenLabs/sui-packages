module 0xab469efda11b7fdd7986b404cc6f831b8571ece0ad5c64db064af38fb3dd86a6::hpn {
    struct HPN has drop {
        dummy_field: bool,
    }

    fun init(arg0: HPN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HPN>(arg0, 9, b"HPN", b"Hanpon", b"Hanpon ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/86c3429f-8d3c-455b-9083-679e07e7606b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HPN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HPN>>(v1);
    }

    // decompiled from Move bytecode v6
}

