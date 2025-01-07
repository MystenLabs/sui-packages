module 0x10486b74f934910781b250996f4d653267bf7c7937edc3b14ac626af770755f4::weird_dog {
    struct WEIRD_DOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEIRD_DOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEIRD_DOG>(arg0, 9, b"WEIRD_DOG", b"FOLLOWCOME", x"54686973206d656d6520646573637269626573206120646f6720776974682066756e6e79206c6f6f6b7320f09fa4a3", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ca67967a-3dcf-4868-a3bc-b7e906c52597.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEIRD_DOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEIRD_DOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

