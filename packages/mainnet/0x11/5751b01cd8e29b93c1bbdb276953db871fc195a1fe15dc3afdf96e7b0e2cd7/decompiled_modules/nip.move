module 0x115751b01cd8e29b93c1bbdb276953db871fc195a1fe15dc3afdf96e7b0e2cd7::nip {
    struct NIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: NIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NIP>(arg0, 9, b"NIP", b"Catnip", x"4361746e6970206973206120706c617966756c206d656d6520746f6b656e20696e73706972656420627920746865206a6f79206361747320657870657269656e63652077697468206361746e697021204a6f696e20612066756e2d6c6f76696e6720636f6d6d756e6974792063656c6562726174696e67206f75722066656c696e6520667269656e6473207768696c6520656e6a6f79696e672061206c6967687468656172746564206a6f75726e6579207468726f756768207468652063727970746f20776f726c642e204c6574e2809973206d616b65207468697320616476656e7475726520707572722d666563746c79206d656d6f7261626c6521", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7374d2a2-3133-4cb4-91c9-1d6ff059f22e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NIP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NIP>>(v1);
    }

    // decompiled from Move bytecode v6
}

