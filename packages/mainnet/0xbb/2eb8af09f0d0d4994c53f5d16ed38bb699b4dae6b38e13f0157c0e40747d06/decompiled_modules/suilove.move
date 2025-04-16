module 0xbb2eb8af09f0d0d4994c53f5d16ed38bb699b4dae6b38e13f0157c0e40747d06::suilove {
    struct SUILOVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILOVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILOVE>(arg0, 9, b"SUIlOVE", x"537569206c6f766520f09f9296", x"537569204c6f76652028535549204c4f5645293a204120746f6b656e206f6e207468652053756920626c6f636b636861696e2c20737072656164696e67206c6f766520616e64207472757374207769746820666173742c207365637572652c20616e64206c6f772d636f7374207472616e73616374696f6e732e204a6f696e206f757220636f6d6d756e69747920746f20636f6e6e65637420616e6420656d706f7765722120f09f9295", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/d721a0a0e401e90857538bf60d5d86aablob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUILOVE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILOVE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

