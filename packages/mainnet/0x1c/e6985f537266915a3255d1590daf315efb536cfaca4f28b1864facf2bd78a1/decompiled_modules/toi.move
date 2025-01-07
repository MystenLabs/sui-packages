module 0x1ce6985f537266915a3255d1590daf315efb536cfaca4f28b1864facf2bd78a1::toi {
    struct TOI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOI>(arg0, 9, b"TOI", b"Toilet", b"Fucking tiloet", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4ace5454-26c1-42b5-b4a6-0bc0b72e232b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOI>>(v1);
    }

    // decompiled from Move bytecode v6
}

