module 0x34df70122b6b5f63342320fe177f6ac51bddd6fb745c7b4359d2f33bf6240d1c::meomeo {
    struct MEOMEO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEOMEO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEOMEO>(arg0, 9, b"MEOMEO", b"meomeo", b"meomeopump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/59ed7847-65d6-4bff-a186-1457b1909fc9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEOMEO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEOMEO>>(v1);
    }

    // decompiled from Move bytecode v6
}

