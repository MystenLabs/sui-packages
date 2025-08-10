module 0x22b0255c9afa6d112984a3dd8f5f7323a1a1867c415072f137f4784d4d5172f4::stable_coin {
    struct STABLE_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: STABLE_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STABLE_COIN>(arg0, 6, b"symbolUSD", b"nameUSD", b"descriptionUSD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"iconUSD")), arg1);
        0x2::transfer::public_transfer<0x9c74fde1ea61797935b9e534e7eb66d6bf65803aa20cb71423ab9ba5abd22e4b::vault::CreateVaultCap<STABLE_COIN>>(0x9c74fde1ea61797935b9e534e7eb66d6bf65803aa20cb71423ab9ba5abd22e4b::vault::to_create_vault_cap<STABLE_COIN>(v0, v1, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

