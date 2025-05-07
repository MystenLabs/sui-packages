module 0xe7d191c597f43c8236d1ffb92e6bff6fab820ee3efa787b9c53ddcfc8e05fd57::miu {
    struct MIU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIU>(arg0, 6, b"MIU", b"Miu Coin", x"4d49553a2054686520756c74696d61746520636174206d656d6520746f6b656e206f6e2074686520537569204e6574776f726b212046756e2c207374616b696e672c20616e6420706f77657266756c20746f6f6c7320636f6d62696e6564207769746820656e646c657373207075727266656374696f6e2e204a6f696e20757320616e64206c6561766520796f757220706177207072696e74206f6e2074686520626c6f636b636861696e210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_606fc4a5c9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MIU>>(v1);
    }

    // decompiled from Move bytecode v6
}

