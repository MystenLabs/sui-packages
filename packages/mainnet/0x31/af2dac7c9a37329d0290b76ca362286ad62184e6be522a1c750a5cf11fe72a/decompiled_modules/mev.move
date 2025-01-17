module 0x31af2dac7c9a37329d0290b76ca362286ad62184e6be522a1c750a5cf11fe72a::mev {
    struct MEV has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEV>(arg0, 6, b"MEV", b"MEV AGENT", x"4175746f6d6174652070726f66697473206f6e20535549207769746820616476616e636564204149204167656e740a0a466173742c20656666696369656e742c20616e642066756c6c79206175746f6d617465646e6f207369676e616c732c206e6f206775657373776f726b2e20596f7572206761746577617920746f20736d61727465722044654669206561726e696e6773", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250117_191112_359_38481bee1c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEV>>(v1);
    }

    // decompiled from Move bytecode v6
}

