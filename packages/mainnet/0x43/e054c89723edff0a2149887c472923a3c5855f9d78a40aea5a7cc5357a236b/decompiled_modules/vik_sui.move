module 0x43e054c89723edff0a2149887c472923a3c5855f9d78a40aea5a7cc5357a236b::vik_sui {
    struct VIK_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: VIK_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VIK_SUI>(arg0, 9, b"vikSUI", b"Viking Staked SUI", b"Sui Viking", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.tusky.io/files/6e0d8d0c-b909-4326-87b2-0af5cef6f4d8/data")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VIK_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VIK_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

