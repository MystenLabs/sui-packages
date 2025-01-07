module 0x50b989b16512c9e5052c51f39d37039a4a6085a3d58abd0ae880ae005bba4d4c::giko {
    struct GIKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GIKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GIKO>(arg0, 6, b"GIKO", b"Gikoonsui", x"4d414b452047494b4f204d454d4553210a3e54616b65206f7665722074686520776f726c6427732074696d656c696e6573207769746820746865206c617465737420484f542047494b4f206d656d65206f72205046502e204d61646520627920796f752e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000036076_dea0d67829.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GIKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GIKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

