module 0x7ec811ed8fc1a22551b67f1d7afdbe7879c1bab892edc5335669a18087e1bf75::jdjdh {
    struct JDJDH has drop {
        dummy_field: bool,
    }

    fun init(arg0: JDJDH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JDJDH>(arg0, 9, b"JDJDH", b"Bshah", b"Hdjdh", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ef1e6440-4437-4eed-94bc-a80e8f6aff5a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JDJDH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JDJDH>>(v1);
    }

    // decompiled from Move bytecode v6
}

