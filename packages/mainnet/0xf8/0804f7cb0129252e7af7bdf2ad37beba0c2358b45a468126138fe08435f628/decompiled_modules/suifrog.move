module 0xf80804f7cb0129252e7af7bdf2ad37beba0c2358b45a468126138fe08435f628::suifrog {
    struct SUIFROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIFROG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SUIFROG>(arg0, 6, 0x1::string::utf8(b"SUIFROG"), 0x1::string::utf8(b"suifrog"), 0x1::string::utf8(x"73756966726f6720e28094206c61756e63686564206f6e205375692066726f6d20536f6c616e61"), 0x1::string::utf8(b"https://aynb7ojmit1wvfv3.public.blob.vercel-storage.com/icons/23273fd4-7270-4f66-b8a1-f0806c03695d.webp"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIFROG>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<SUIFROG>>(0x2::coin_registry::finalize<SUIFROG>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

