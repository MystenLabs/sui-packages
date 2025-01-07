module 0x427abcdb729491c33781b9c2fc06cbb5d5497c22f8a4aa52c533aae4c36917a1::pmp {
    struct PMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PMP>(arg0, 9, b"PMP", b"Pump", b"Pump on Wave", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/13265161-8f37-4b10-b771-eec574244792.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

