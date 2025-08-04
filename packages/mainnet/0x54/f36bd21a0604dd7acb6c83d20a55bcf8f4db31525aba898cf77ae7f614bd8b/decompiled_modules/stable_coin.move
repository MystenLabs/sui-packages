module 0x54f36bd21a0604dd7acb6c83d20a55bcf8f4db31525aba898cf77ae7f614bd8b::stable_coin {
    struct STABLE_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: STABLE_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STABLE_COIN>(arg0, 6, b"symbolUSD", b"nameUSD", b"descriptionUSD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"iconUSD")), arg1);
        0x2::transfer::public_transfer<0x3d59d152ab8f45dd63af35619f23039df756c7614cc72cf49a36d9f24352dabb::vault::CreateVaultCap<STABLE_COIN>>(0x3d59d152ab8f45dd63af35619f23039df756c7614cc72cf49a36d9f24352dabb::vault::to_create_vault_cap<STABLE_COIN>(v0, v1, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

