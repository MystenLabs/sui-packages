module 0xb21f28a6b6ea3037e28e076e33601ef5d4e322a7b2c7ba5426ed0e8e2980403::sland {
    struct SLAND has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLAND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SLAND>(arg0, 6, 0x1::string::utf8(b"SLAND"), 0x1::string::utf8(b"SUILAND"), 0x1::string::utf8(b"SUILAND ($SLAND) is a fair-launch memecoin on Sui, created on the POPULAR launchpad. Total supply is 1 billion tokens, with no team allocation."), 0x1::string::utf8(b"https://popularsui.xyz/media/9baa35f32b458e30db4b35d0190c17616e4683e9ffcccdd04707208938487cfa.webp"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLAND>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<SLAND>>(0x2::coin_registry::finalize<SLAND>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

