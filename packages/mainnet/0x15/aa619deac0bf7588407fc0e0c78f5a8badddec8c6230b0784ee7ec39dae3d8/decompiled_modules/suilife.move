module 0x15aa619deac0bf7588407fc0e0c78f5a8badddec8c6230b0784ee7ec39dae3d8::suilife {
    struct SUILIFE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILIFE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILIFE>(arg0, 9, b"SHUIREN", x"535549e4babae7949f", x"53554920636f6d65732066726f6d206a6170616e65736520e6b0b42c20616c736f207573656420696e206368696e657365206173203c77617465723e2e20436f6d652c206a6f696e20746865206c696665206f66207468652077617465723a2074686520535549204c696665202d20e6b0b4e4babae7949f2e2054473a2068747470733a2f2f742e6d652f736875694c696665", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmbDuNF3GinZroaoj6v68UiWTEcFrE5oNtwMkTLwks955R")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUILIFE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILIFE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

