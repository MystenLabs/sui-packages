module 0xa0609e0b0cc58dc9020f2f7aecb575c8ab5c51bc4f3d9e39d1ba969d59909c45::wewecat {
    struct WEWECAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEWECAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEWECAT>(arg0, 9, b"WEWECAT", b"Wpump", b"Am bullish on WEWE token about to be launched on Sui Blockchain.I am super sure it will be massive.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6c079713-a304-4ff6-baa4-81202f7b1065.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEWECAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEWECAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

