module 0xe862499b65238b975c33874aab2b0ba791d37927048db93e1ab5b7d73e4aeae9::scallop_cetus {
    struct SCALLOP_CETUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCALLOP_CETUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCALLOP_CETUS>(arg0, 9, b"sCETUS", b"sCETUS", b"Scallop interest-bearing token for CETUS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://4oe4m5wt7djfe6tise6v7nrpv34wvonvtecvmllf73kjtshgqnaq.arweave.net/44nGdtP40lJ6aJE9X7YvrvlqubWZBVYtZf7Umcjmg0E")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCALLOP_CETUS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCALLOP_CETUS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

