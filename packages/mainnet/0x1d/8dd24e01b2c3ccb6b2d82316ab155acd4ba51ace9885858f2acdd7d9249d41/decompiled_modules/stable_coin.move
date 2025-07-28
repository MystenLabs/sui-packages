module 0x1d8dd24e01b2c3ccb6b2d82316ab155acd4ba51ace9885858f2acdd7d9249d41::stable_coin {
    struct STABLE_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: STABLE_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STABLE_COIN>(arg0, 6, b"symbolUSD", b"nameUSD", b"descriptionUSD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"iconUSD")), arg1);
        0x2::transfer::public_transfer<0xfe36b2cb90a69f1d465a49ad57adeca82d7df45dff2998a8bae7d2c8ae965625::vault::CreateVaultCap<STABLE_COIN>>(0xfe36b2cb90a69f1d465a49ad57adeca82d7df45dff2998a8bae7d2c8ae965625::vault::to_create_vault_cap<STABLE_COIN>(v0, v1, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

