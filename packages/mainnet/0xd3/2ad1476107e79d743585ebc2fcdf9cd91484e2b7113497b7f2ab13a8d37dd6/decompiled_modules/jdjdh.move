module 0xd32ad1476107e79d743585ebc2fcdf9cd91484e2b7113497b7f2ab13a8d37dd6::jdjdh {
    struct JDJDH has drop {
        dummy_field: bool,
    }

    fun init(arg0: JDJDH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JDJDH>(arg0, 9, b"JDJDH", b"Bshah", b"Hdjdh", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cb8bf440-619d-472f-a70f-debc54fbe25d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JDJDH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JDJDH>>(v1);
    }

    // decompiled from Move bytecode v6
}

