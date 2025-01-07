module 0x7834aee65096722190abd2383f666e715b80d666cb8e95c3f4ce5a64e3e28f3e::madara {
    struct MADARA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MADARA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MADARA>(arg0, 9, b"MADARA", b"Madara Uch", b"Madara Uch namaste Maharaj namaste ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/34648409-3e88-4028-aa3b-7967486d11a0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MADARA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MADARA>>(v1);
    }

    // decompiled from Move bytecode v6
}

