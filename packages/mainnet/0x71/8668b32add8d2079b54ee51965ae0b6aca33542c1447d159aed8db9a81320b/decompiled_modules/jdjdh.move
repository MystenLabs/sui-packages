module 0x718668b32add8d2079b54ee51965ae0b6aca33542c1447d159aed8db9a81320b::jdjdh {
    struct JDJDH has drop {
        dummy_field: bool,
    }

    fun init(arg0: JDJDH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JDJDH>(arg0, 9, b"JDJDH", b"Bshah", b"Hdjdh", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7b03bc60-30a5-4407-af86-1f6aa4da569c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JDJDH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JDJDH>>(v1);
    }

    // decompiled from Move bytecode v6
}

