module 0x1d21ad3d90809e32c47142651a2e397a0cde2939f043b0837ed5ca1fdba8d158::trenches {
    struct TRENCHES has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRENCHES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<TRENCHES>(arg0, 6, 0x1::string::utf8(b"TRENCHES"), 0x1::string::utf8(b"Suway trenches"), 0x1::string::utf8(b"We are rebuilding the trenches."), 0x1::string::utf8(b"https://popularsui.xyz/media/6b57d0309f61a0b9fe4263b42618b72bd5ac8cd138d1a19feaeb742e0db1c562.webp"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRENCHES>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<TRENCHES>>(0x2::coin_registry::finalize<TRENCHES>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

