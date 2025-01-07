module 0x73519a2125d50d62daaf6a9769c2102e37cf0283fa8cfbb849159e80cd058a1c::jdjdh {
    struct JDJDH has drop {
        dummy_field: bool,
    }

    fun init(arg0: JDJDH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JDJDH>(arg0, 9, b"JDJDH", b"Bshah", b"Hdjdh", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/25a84717-72e2-4765-9943-b24d22e61b60.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JDJDH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JDJDH>>(v1);
    }

    // decompiled from Move bytecode v6
}

