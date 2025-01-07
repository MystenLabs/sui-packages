module 0x3e2db784f8f5bb2c028bff47eaeb3ad35c955647727bfff6136da105db53bd65::bnk88 {
    struct BNK88 has drop {
        dummy_field: bool,
    }

    fun init(arg0: BNK88, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BNK88>(arg0, 9, b"BNK88", b"bnk", b"gg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f0b7e8ed-d999-4d9a-8d77-d8a5b29a2590.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BNK88>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BNK88>>(v1);
    }

    // decompiled from Move bytecode v6
}

