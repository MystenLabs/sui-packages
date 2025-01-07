module 0x789d55c728d7c32abe7667dfe99b8e672182e5ade14819b7f731a1ce48decc70::skydog {
    struct SKYDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKYDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKYDOG>(arg0, 9, b"SKYDOG", b"sky coin", b"sky is name for my dog, she's cute fr ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ae1d9617-54c7-4983-a2c2-cde3015d5f5d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKYDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SKYDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

