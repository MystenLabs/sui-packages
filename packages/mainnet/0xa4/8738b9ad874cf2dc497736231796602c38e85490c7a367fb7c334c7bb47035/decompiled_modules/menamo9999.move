module 0xa48738b9ad874cf2dc497736231796602c38e85490c7a367fb7c334c7bb47035::menamo9999 {
    struct MENAMO9999 has drop {
        dummy_field: bool,
    }

    fun init(arg0: MENAMO9999, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MENAMO9999>(arg0, 9, b"MENAMO9999", b"MENAMO", b"mua di cac bro nhe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/369a3af9-1d2f-4f63-9e42-6301ce04848b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MENAMO9999>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MENAMO9999>>(v1);
    }

    // decompiled from Move bytecode v6
}

