module 0x5f442395e4e6075c711b995226e689474b8e54cc535aa58db0975b5e0d0fd3a7::suipepe {
    struct SUIPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPEPE>(arg0, 6, b"SUIPEPE", b"SUI PEPE", x"596f7572204661766f72697465205065706520636f6d696e6720746f205355490a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731004624398.PNG")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIPEPE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPEPE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

