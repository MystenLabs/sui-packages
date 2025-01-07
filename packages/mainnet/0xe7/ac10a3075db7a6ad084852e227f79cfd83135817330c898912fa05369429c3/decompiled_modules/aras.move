module 0xe7ac10a3075db7a6ad084852e227f79cfd83135817330c898912fa05369429c3::aras {
    struct ARAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARAS>(arg0, 9, b"ARAS", b"Arastoo", b"IRAN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/52be7bed-7938-4636-90a1-8b832f561bde.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ARAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

