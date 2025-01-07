module 0x5935605051797a71d0b044f1904bb39b4f5933eca645d0e3c9332a7495d36228::wjkhkjhjkh {
    struct WJKHKJHJKH has drop {
        dummy_field: bool,
    }

    fun init(arg0: WJKHKJHJKH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WJKHKJHJKH>(arg0, 9, b"WJKHKJHJKH", b"gffhgfhgf", b"gfvhgfghjfg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/05e45d9d-6bb3-4dba-9eec-08139a240baf.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WJKHKJHJKH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WJKHKJHJKH>>(v1);
    }

    // decompiled from Move bytecode v6
}

