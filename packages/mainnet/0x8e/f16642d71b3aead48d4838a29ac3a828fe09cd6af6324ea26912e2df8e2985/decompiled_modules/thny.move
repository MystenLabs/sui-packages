module 0x8ef16642d71b3aead48d4838a29ac3a828fe09cd6af6324ea26912e2df8e2985::thny {
    struct THNY has drop {
        dummy_field: bool,
    }

    fun init(arg0: THNY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THNY>(arg0, 9, b"THNY", b"THONY", x"54686f6e793a20546865204d656d6520436f696e205265766f6c7574696f6e0a0a54686f6e79206973206d6f7265207468616e206a75737420612063727970746f63757272656e6379202d20697427732061206d6f76656d656e742e205468697320706c617966756c2c20636f6d6d756e6974792d64726976656e20636f696e20706f6b65732066756e2061742074686520736572696f75736e657373206f66207468652063727970746f207370616365207768696c6520656d62726163696e672069747320756e707265646963746162696c6974792e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/900b560d-4b31-49d1-a2d5-aea1908528c8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THNY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<THNY>>(v1);
    }

    // decompiled from Move bytecode v6
}

