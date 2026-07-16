module 0x37438f4e6a34fbb34f157de844b0f90d589f056463ce9188b0ab4f0cae0a3343::dmc {
    struct DMC has drop {
        dummy_field: bool,
    }

    fun init(arg0: DMC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DMC>(arg0, 9, b"DMC", b"DeLorean", x"44654c6f7265616ee28099732070726f746f636f6c20697320616e20696e647573747279206669727374206f6e2d636861696e2076656869636c65207265736572766174696f6e20616e6420616e616c79746963732073797374656d2064657369676e656420746f20736f6c7665207265616c2d776f726c642069737375657320666163696e6720746865206175746f6d6f7469766520736563746f722e20417420746865206865617274206f66207468652044654c6f7265616e2065636f73797374656d206c6965732024444d432c206120746f6b656e207468617420636f6d62696e65732063756c747572616c207369676e69666963616e63652c207574696c6974792c20616e6420746865206261636b696e67206f6620616e2069636f6e69632057656232206272616e642e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.googleapis.com/tokenimage.deloreanlabs.com/DMCTokenIcon.svg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DMC>>(v1);
        0x2::coin::mint_and_transfer<DMC>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DMC>>(v2, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<DMC>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<DMC>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v7
}

