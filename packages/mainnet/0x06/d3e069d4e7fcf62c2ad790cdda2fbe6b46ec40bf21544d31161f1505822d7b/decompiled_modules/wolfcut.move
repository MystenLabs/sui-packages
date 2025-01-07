module 0x6d3e069d4e7fcf62c2ad790cdda2fbe6b46ec40bf21544d31161f1505822d7b::wolfcut {
    struct WOLFCUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOLFCUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOLFCUT>(arg0, 6, b"WOLFCUT", b"Wolfcut On Sui", b"An innovative token in the crypto world that combines advanced technology with a strong community. Join our journey to build a secure and profitable ec.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730447515099.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WOLFCUT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOLFCUT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

