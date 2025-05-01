module 0x9075c79774aa54e1013286d50c24d2be7c1fdc609644838236e6f76b96b33297::trx_sui {
    struct TRX_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRX_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRX_SUI>(arg0, 9, b"trxSUI", b"Tron Staked SUI", b"Tron Staked Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.tusky.io/files/88b15d7e-a0d0-4fed-9486-c500f3ca1be7/data")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRX_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRX_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

