module 0x29c20490fb6f7be414475359b4fc30289234e506b70d2bca21fd4174af984321::wave {
    struct WAVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAVE>(arg0, 9, b"WAVE", b"Face", x"6973206d6f7265207468616e2061206d656d65636f696ee280946974e28099732061206d6f76656d656e74206675656c65642062792068756d6f722c20636f6d6d756e6974792c20616e64206d6f6f6e73686f7420647265616d73", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b49cf610-e6c5-4b78-aa9c-ac7164dce511.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

