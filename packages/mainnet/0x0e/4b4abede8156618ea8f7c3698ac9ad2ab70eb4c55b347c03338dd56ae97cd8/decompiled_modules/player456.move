module 0xe4b4abede8156618ea8f7c3698ac9ad2ab70eb4c55b347c03338dd56ae97cd8::player456 {
    struct PLAYER456 has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLAYER456, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLAYER456>(arg0, 6, b"PLAYER456", b"PLAYER 456", x"4d6565742024504c415945523435362c2074686520756c74696d617465206d656d65636f696e20696e7370697265642062792053656f6e672047692d68756e2c20746865206c617374206d616e207374616e64696e672066726f6d2053717569642047616d652e204a757374206c696b652068696d2c207468697320746f6b656e207374617274732066726f6d2074686520626f74746f6d20627574206973206275696c7420746f20737572766976652c207468726976652c20616e642077696e2062696720e28094206f6e20746865206c696768746e696e672d6661737420537569204e6574776f726b2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1749577364470.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PLAYER456>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLAYER456>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

