module 0x8cc655eedcba0b58d38324593614eb9cf7ce4ce436058e014e395651caf2c159::lip {
    struct LIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIP>(arg0, 9, b"LIP", b"lip", x"5075636b657220757020666f722070726f666974732077697468204c6970436f696e3a20546865207374796c6973682063727970746f63757272656e63792074686174277320616464696e67206120746f756368206f6620676c616d6f757220746f20796f757220706f7274666f6c696f2c2064656c69766572696e67206b69737361626c65206761696e7320616e64206120746f756368206f6620736f706869737469636174696f6e2120f09f928bf09f92b0", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2f15b03c-06a6-48c7-bc8f-c0e183d76c5f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LIP>>(v1);
    }

    // decompiled from Move bytecode v6
}

