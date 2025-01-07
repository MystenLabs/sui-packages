module 0x880c452b3e6daca26af7d172fe9fa3c310441c77144e027ee4349d70b7800ae1::noir {
    struct NOIR has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOIR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOIR>(arg0, 6, b"NOIR", b"NOIR ON SUI ", x"48692069276d204e6f69722c205468652073617661676520343034206d6f6e6b6579206f6e200a405375696e6574776f726b0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731481873684.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NOIR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOIR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

