module 0x4f59c2280372d331bd747963001011ccc6347ddce34c995a8949bcd29c0ad477::chari {
    struct CHARI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHARI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<CHARI>(arg0, 6, b"CHARI", b"Charizard", x"416e206f72616e67652c20647261676f6e2d6c696b6520506f6bc3a96d6f6e2c2043686172697a617264206973207468652065766f6c76656420666f726d206f6620436861726d656c656f6e20616e64207468652066696e616c2065766f6c7574696f6e206f6620436861726d616e6465722e20497420616c736f206861732074776f20274d6567612045766f6c7665642720666f726d732c204d6567612043686172697a617264205820616e6420592c20746861742077657265206c696b656c7920626f74682064657369676e656420627920546f6d6f6869726f204b6974616b617a652c207468652064657369676e6572206f66204d6567612043686172697a61726420582e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_4341_29ab743e2f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CHARI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHARI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

