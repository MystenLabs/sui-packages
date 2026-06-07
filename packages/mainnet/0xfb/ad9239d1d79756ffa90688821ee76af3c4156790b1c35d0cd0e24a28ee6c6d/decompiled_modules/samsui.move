module 0xfbad9239d1d79756ffa90688821ee76af3c4156790b1c35d0cd0e24a28ee6c6d::samsui {
    struct SAMSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAMSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SAMSUI>(arg0, 9, 0x1::string::utf8(b"samsui"), 0x1::string::utf8(b"Sam SUI"), 0x1::string::utf8(b"Sam SUI"), 0x1::string::utf8(b"https://usesam.xyz/tokens/samsui.svg"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAMSUI>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<SAMSUI>>(0x2::coin_registry::finalize<SAMSUI>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

