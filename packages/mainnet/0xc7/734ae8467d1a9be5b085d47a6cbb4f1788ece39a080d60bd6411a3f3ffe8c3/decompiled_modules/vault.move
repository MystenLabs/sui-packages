module 0xc7734ae8467d1a9be5b085d47a6cbb4f1788ece39a080d60bd6411a3f3ffe8c3::vault {
    struct VAULT has drop {
        dummy_field: bool,
    }

    fun init(arg0: VAULT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VAULT>(arg0, 9, b"NVDAF", b"Counterfeit NVDA", b"Unrelated coin type; ticker spoofed via Arena bridge generic create_vault.", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VAULT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VAULT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

