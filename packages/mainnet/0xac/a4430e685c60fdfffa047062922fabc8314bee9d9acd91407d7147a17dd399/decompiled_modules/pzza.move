module 0xaca4430e685c60fdfffa047062922fabc8314bee9d9acd91407d7147a17dd399::pzza {
    struct PZZA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PZZA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PZZA>(arg0, 9, b"PZZA", b"PizzaCoin ", x"50697a7a61436f696e2028505a5a412920697320612064656c6963696f75736c792066756e206d656d6520746f6b656e20696e7370697265642062792065766572796f6e65e2809973206c6f766520666f722070697a7a61212057697468206120636f6d6d756e697479207468617420617070726563696174657320626f746820676f6f6420666f6f642c2050697a7a61436f696e20697320616c6c2061626f757420636865657379207265776172647320616e6420736c6963652d6f662d6c696665206d6f6d656e74732e204a6f696e207468652050697a7a61436f696e20706172747921", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6b8974e7-121d-4db4-9080-a7d71f88fe3d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PZZA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PZZA>>(v1);
    }

    // decompiled from Move bytecode v6
}

