module 0x90a6d33da74f20ecf4fae7b0dcd3ac3a69fef8f8b09496a074b26b671f9aaf46::clean {
    struct CLEAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLEAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<CLEAN>(arg0, 6, 0x1::string::utf8(b"CLEAN"), 0x1::string::utf8(b"Cleaner"), 0x1::string::utf8(x"596f7572205375692077616c6c657420636f6e7461696e73206d6f7265207468616e20796f75722062616c616e63652e0a546f6b656e732e204e4654732e2050726f746f636f6c206f626a656374732e20556e6b6e6f776e206173736574732e20456d707479206c6566746f766572732e0a537569436c65616e65722068656c707320796f7520756e6465727374616e642077686174277320696e7369646520616e6420636c65616e20776861742063616e2061637475616c6c792062652072656d6f7665642e0a0a416e616c797a6520e286922052657669657720e2869220436c65616e20e28692205369676e"), 0x1::string::utf8(b"https://popularsui.xyz/media/bdbc1129c69393db22225a9225991365640fa726e025a88f6a213b82525cfaa0.webp"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLEAN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<CLEAN>>(0x2::coin_registry::finalize<CLEAN>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

