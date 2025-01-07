module 0xdd8556e188c9a1011074da6a9118e306db0b847b2bb96dc418abec99ac051bec::memc {
    struct MEMC has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMC>(arg0, 9, b"MEMC", b"MemeX", x"4d656d65582069732074686520756c74696d61746520636f6d6d756e6974792d64726976656e206d656d65636f696e2074686174206272696e677320746f676574686572207468652066756e206f6620696e7465726e65742063756c7475726520776974682074686520706f776572206f6620626c6f636b636861696e2e2044657369676e656420746f20726577617264206c6f79616c20686f6c6465727320616e64206d656d652063726561746f72732c204d656d6558206973206d6f7265207468616e206a757374206120746f6b656ee2809469742773206120736f6369616c206d6f76656d656e742e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6f1406e5-e922-43c1-a7be-fd21b50a7ffd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMC>>(v1);
    }

    // decompiled from Move bytecode v6
}

