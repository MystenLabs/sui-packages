module 0x536abd1aa17f0db73177541f5adf6efc18607d1cf78845f601530e8ca1fef79::b_sui {
    struct B_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_SUI>(arg0, 9, b"bSUI", b"bToken SUI", b"Steamm bToken", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<B_SUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

