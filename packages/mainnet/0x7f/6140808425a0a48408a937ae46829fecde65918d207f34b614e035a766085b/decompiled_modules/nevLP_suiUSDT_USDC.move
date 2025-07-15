module 0x7f6140808425a0a48408a937ae46829fecde65918d207f34b614e035a766085b::nevLP_suiUSDT_USDC {
    struct NEVLP_SUIUSDT_USDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEVLP_SUIUSDT_USDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEVLP_SUIUSDT_USDC>(arg0, 9, b"sy-nevLP-suiUSDT-USDC", b"SY nevLP-suiUSDT-USDC", b"SY nevLP-suiUSDT-USDC", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NEVLP_SUIUSDT_USDC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEVLP_SUIUSDT_USDC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

