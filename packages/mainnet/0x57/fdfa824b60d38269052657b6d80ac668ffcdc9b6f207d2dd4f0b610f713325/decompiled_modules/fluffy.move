module 0x57fdfa824b60d38269052657b6d80ac668ffcdc9b6f207d2dd4f0b610f713325::fluffy {
    struct FLUFFY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLUFFY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLUFFY>(arg0, 6, b"FLUFFY", b"Fluffnir", x"224c6574206d6520737061726b6c657320746865207061746820746f20746865206d6f6f6e20f09f8c9922200a48656c6c6f20616476656e74757265722c20466c7566666e69722069732061207261726520616e6420656e6368616e74696e6720666f72657374206477656c6c657220f09f8d84f09f8cb30a0a3e20566973697420746865207765627369746520746f20646973636f766572206869732077686f6c6520756e6976657273650a0a546865206f626a65637469766520697320746f20637265617465206120636f6d6d756e697479206f6620666c7566666965732061726f756e642074686520466c7566667920776f726c642e0a484f444c", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1733179802315.PNG")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FLUFFY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLUFFY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

