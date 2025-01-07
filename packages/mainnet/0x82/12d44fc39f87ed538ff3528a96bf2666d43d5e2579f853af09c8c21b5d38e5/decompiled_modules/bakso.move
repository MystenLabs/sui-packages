module 0x8212d44fc39f87ed538ff3528a96bf2666d43d5e2579f853af09c8c21b5d38e5::bakso {
    struct BAKSO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAKSO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAKSO>(arg0, 9, b"BAKSO", b"Bakso Bang", b"Inspired by traditional Indonesian food, namely yummy meatballs!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/850c8b01-18fe-4522-aa90-d214bd371996.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAKSO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BAKSO>>(v1);
    }

    // decompiled from Move bytecode v6
}

