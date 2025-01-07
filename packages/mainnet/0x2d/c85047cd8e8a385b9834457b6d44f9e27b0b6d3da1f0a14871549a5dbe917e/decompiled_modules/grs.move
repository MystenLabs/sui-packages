module 0x2dc85047cd8e8a385b9834457b6d44f9e27b0b6d3da1f0a14871549a5dbe917e::grs {
    struct GRS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRS>(arg0, 6, b"GRS", b"The Grinch on Sui", x"546865204772696e6368206f6e205375692069732061206d656d65636f696e20697320612066696374696f6e616c206368617261637465722077686f2068617465204368726973746d61732e0a4120677265656e2c2066757272792c20706561722d7368617065642068756d616e6f69642077697468206120706f742062656c6c792c20736e7562206e6f73652c20616e64206361742d6c696b6520666163652e204865206861732079656c6c6f77206579657320616e642061206772756d70792066726f776e206f72207769636b6564206772696e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735308956150.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GRS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

