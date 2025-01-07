module 0x7cc486522c236f611ce381fc47dd4f44b922ccb5c1aee859ed6543decc6f1ced::fdm {
    struct FDM has drop {
        dummy_field: bool,
    }

    fun init(arg0: FDM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FDM>(arg0, 6, b"FDM", b"Foxxi Degen Mode", b"Don't underestimate Foxxi, because she's in Degen mode... Bring out your wild side", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731495483881.gif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FDM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FDM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

