module 0x5d98d6cd9c93483e13d0ed7b8c29c142da95ecd3341b79e56ff954a6d27d1369::nnffs {
    struct NNFFS has drop {
        dummy_field: bool,
    }

    fun init(arg0: NNFFS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NNFFS>(arg0, 9, b"NNFFS", b"NNF", b"NFF", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0044e8a9-a026-4c70-97bc-39f32ca76278.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NNFFS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NNFFS>>(v1);
    }

    // decompiled from Move bytecode v6
}

