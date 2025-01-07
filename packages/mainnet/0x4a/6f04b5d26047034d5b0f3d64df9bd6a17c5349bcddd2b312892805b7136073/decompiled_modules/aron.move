module 0x4a6f04b5d26047034d5b0f3d64df9bd6a17c5349bcddd2b312892805b7136073::aron {
    struct ARON has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARON>(arg0, 6, b"ARON", b"Aron's Vault", b"Aron's Vault is a memecoin inspired by the journey of Aron and Toro Maximus. It represents the quest for financial freedom and the unity of the crypto community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735302971111.17")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ARON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARON>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

