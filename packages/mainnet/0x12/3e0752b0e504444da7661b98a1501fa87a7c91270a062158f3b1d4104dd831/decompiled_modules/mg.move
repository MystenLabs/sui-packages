module 0x123e0752b0e504444da7661b98a1501fa87a7c91270a062158f3b1d4104dd831::mg {
    struct MG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MG>(arg0, 9, b"MG", b"MOOGON", b"MOOGON IN SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b9c5130f-16a2-412c-99ac-ae78fdba72e9-1000009547.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MG>>(v1);
    }

    // decompiled from Move bytecode v6
}

