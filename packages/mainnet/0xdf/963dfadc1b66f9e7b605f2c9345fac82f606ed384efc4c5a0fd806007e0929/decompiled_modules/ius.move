module 0xdf963dfadc1b66f9e7b605f2c9345fac82f606ed384efc4c5a0fd806007e0929::ius {
    struct IUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: IUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<IUS>(arg0, 6, 0x1::string::utf8(b"IUS"), 0x1::string::utf8(b"IUS"), 0x1::string::utf8(b"Reverse Sui"), 0x1::string::utf8(b"https://popularsui.xyz/media/bc67d43c2be3e1b75bf1634fed30b043bc27369014eaf9bd59cbab97b93a3c11.png"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IUS>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<IUS>>(0x2::coin_registry::finalize<IUS>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

