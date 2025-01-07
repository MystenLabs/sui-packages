module 0xdb99a1ef0519f9d73170c7445760e02bf6838e7772144acf826cb8959eadc664::suisonic {
    struct SUISONIC has drop {
        dummy_field: bool,
    }

    fun create_currency<T0: drop>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<T0> {
        let (v0, v1) = 0x2::coin::create_currency<T0>(arg0, 9, b"SUISONIC", b"SUI SONIC HEDGE HOG", x"5261636520696e746f20616374696f6e207769746820746869732069636f6e69632053554920536f6e69632120f09f8c80f09f92a5204272696e672074686520686967682d737065656420656e65726779206f662065766572796f6e65e2809973206661766f7269746520626c7565206865646765686f6720f09fa694f09f92a820746f20796f7572206465736b746f702e205065726665637420666f7220646567656e7320616e64205355492066616e7320616c696b652120", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gray-distinctive-walrus-769.mypinata.cloud/ipfs/QmeQYxqS2i6u8KtDHs6mvxaR26YwT19G3HqYzQBZyGzdWm")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(v1);
        v0
    }

    fun init(arg0: SUISONIC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = create_currency<SUISONIC>(arg0, arg1);
        0x2::coin::mint_and_transfer<SUISONIC>(&mut v0, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISONIC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

