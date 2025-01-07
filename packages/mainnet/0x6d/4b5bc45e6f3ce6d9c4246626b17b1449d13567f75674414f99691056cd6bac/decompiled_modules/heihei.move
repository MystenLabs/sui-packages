module 0x6d4b5bc45e6f3ce6d9c4246626b17b1449d13567f75674414f99691056cd6bac::heihei {
    struct HEIHEI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEIHEI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEIHEI>(arg0, 9, b"HEIHEI", b"HEI HEI", x"4865692048656920436f696e20e2809320412063727970746f63757272656e637920696e7370697265642062792074686520676f6f667920636869636b656e2048656920486569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0ebbe910-3a7f-4c3a-9127-ac8ebd70cb7f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HEIHEI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HEIHEI>>(v1);
    }

    // decompiled from Move bytecode v6
}

