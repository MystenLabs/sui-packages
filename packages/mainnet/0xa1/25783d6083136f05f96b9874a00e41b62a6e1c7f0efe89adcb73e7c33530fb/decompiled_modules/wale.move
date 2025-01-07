module 0xa125783d6083136f05f96b9874a00e41b62a6e1c7f0efe89adcb73e7c33530fb::wale {
    struct WALE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WALE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WALE>(arg0, 6, b"WALE", b"WALE ON SUI", x"2457616c652069732061206d617373697665206f7267616e69736d207468617420636f756c64206e6f74206d6f7665206f6e206c616e642c20616e642074686973206973207768792057616c65206c6976657320696e20746865207365612e200a5768616c6573206172652066756c6c7920617175617469632c206f70656e2d6f6365616e20616e696d616c733a20746865792063616e20666565642c206d6174652c20676976652062697274682c207375636b6c6520616e6420726169736520746865697220796f756e67206174207365612e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/WALE_6ef714e117.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WALE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WALE>>(v1);
    }

    // decompiled from Move bytecode v6
}

