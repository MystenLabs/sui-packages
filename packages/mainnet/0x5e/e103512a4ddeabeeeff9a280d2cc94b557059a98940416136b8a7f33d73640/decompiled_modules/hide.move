module 0x5ee103512a4ddeabeeeff9a280d2cc94b557059a98940416136b8a7f33d73640::hide {
    struct HIDE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIDE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<HIDE>(arg0, 6, 0x1::string::utf8(b"HIDE"), 0x1::string::utf8(b"Hidey cat"), 0x1::string::utf8(x"f09f90b1204849444520e28094205468652048696464656e20436174206f66205375692e0a4865206469646e2774206469736170706561722e2048652773206a75737420686964696e6720756e646572207468652063686169722e20f09faa91f09f92a70a46696e6420484944452e204d656d6520484944452e20f09f90be0a0ae2809c4865e2809973206e6f7420676f6e652e204865e2809973206a75737420484944452ee2809d20f09f9180f09f90b1"), 0x1::string::utf8(b"https://popularsui.xyz/media/8744ce02a58235fb4a00422d46067000a1c37eb890afe124777c82788146aea7.webp"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIDE>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<HIDE>>(0x2::coin_registry::finalize<HIDE>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

