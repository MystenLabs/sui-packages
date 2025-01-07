module 0xc9a2486bdf7282b27e36dedaab95b116cebcf036745214fbc9110202db6f46c4::monk {
    struct MONK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONK>(arg0, 9, b"MONK", b"Monko", x"4d6f6e6b6f20e2809320746865206d656d6520746f6b656e206272696e67696e672063727970746f2066616e7320616e64206a6f6b65206c6f7665727320746f6765746865722e20496e7370697265642062792069636f6e6963206d656d65732c206f757220736172636173746963206d6f6e6b6579206272696e6773206368616f7320616e6420766962657320746f20746865206d61726b65742e204e6f20e2809c746f20746865206d6f6f6ee2809d2070726f6d6973657320e28093206a757374206d656d65732c20687970652c20616e64206120676c696d6d6572206f6620686f706520666f722061204c616d626f2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/241acdd2-6987-4108-ba8f-df5a3c402289.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MONK>>(v1);
    }

    // decompiled from Move bytecode v6
}

