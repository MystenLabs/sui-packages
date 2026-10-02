module 0x45157d8f45842bda74a9906ea7419392150def2858cb81cbca17da2f430ae062::token {
    struct TOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<TOKEN>(arg0, 6, 0x1::string::utf8(b"DEGEN"), 0x1::string::utf8(b"DEGEN"), 0x1::string::utf8(b"Crypto majors on leverage: BTC, ETH, SOL and SUI, 2x long each, 25% each. An Amped basket on POPULAR."), 0x1::string::utf8(b"https://popular.fun/template.png"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKEN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<TOKEN>>(0x2::coin_registry::finalize<TOKEN>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

