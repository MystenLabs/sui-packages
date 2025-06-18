module 0x13cda3fa8bf4d4dbe2c87763e65c0638855b90dd2a9759be4dece8a69fb56f7b::gabe {
    struct GABE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GABE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GABE>(arg0, 6, b"GABE", b"Gabeonsui", x"416e67656c20746f6b656e202447414245206f6e20407375696e6574776f726b200a0a4865726520746f206272696e67206261636b20706f736974697665206d656d6520766962657320616e6420736f6c696420636f6d6d756e697479", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifmaamm73hb3q5oyoqkw3f4lxo7gms3tclv3omliy422n5g4yslgu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GABE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GABE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

