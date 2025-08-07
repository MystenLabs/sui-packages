module 0x79f2fd93348aae921937431af42e05f6e16491d2a428832b0d55956be7bd7d73::cook_usd {
    struct COOK_USD has drop {
        dummy_field: bool,
    }

    fun init(arg0: COOK_USD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COOK_USD>(arg0, 6, b"cookUSD", b"Cook USD", b"The official yield-bearing stablecoin created by stable.kitchen", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://stable.kitchen/coins/cookusd.svg")), arg1);
        0x2::transfer::public_transfer<0x9c74fde1ea61797935b9e534e7eb66d6bf65803aa20cb71423ab9ba5abd22e4b::vault::CreateVaultCap<COOK_USD>>(0x9c74fde1ea61797935b9e534e7eb66d6bf65803aa20cb71423ab9ba5abd22e4b::vault::to_create_vault_cap<COOK_USD>(v0, v1, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

