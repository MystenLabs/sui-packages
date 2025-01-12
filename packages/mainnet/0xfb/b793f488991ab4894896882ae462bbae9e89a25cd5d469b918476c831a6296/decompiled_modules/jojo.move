module 0xfbb793f488991ab4894896882ae462bbae9e89a25cd5d469b918476c831a6296::jojo {
    struct JOJO has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOJO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOJO>(arg0, 9, b"JOJO", b"MojojojoAI", x"4d6f6a6f204a6f6a6f20414920697320746865206669727374204149206167656e74206f66666572696e6720696e766573746d656e742061647669636520746f206d616e616765207765616c746820696e204465466920616e64205472616446692e205769746820612064697665727365207465616d20696e20576562332c206d61726b6574696e672c20616e642066696e616e63652c20706c75732061207374726f6e6720636f6d6d756e6974792c207765e2809972652073657420746f207472616e73666f726d207468652066696e616e6369616c20696e6475737472792e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f3a00657-30c2-469b-a039-8129542b91a9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOJO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JOJO>>(v1);
    }

    // decompiled from Move bytecode v6
}

