module 0x37fac6ccacc8f8d6931979ecc3b437b1f6ef467098ea0044c15cb4cf2f1f34ef::weo {
    struct WEO has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEO>(arg0, 9, b"WEO", b"Weewoo", b"Weewooweewoo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/700c7434-a41c-4525-9d7d-263e8490a12a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEO>>(v1);
    }

    // decompiled from Move bytecode v6
}

