module 0xaafc4f740de0dd0dde642a31148fb94517087052f19afb0f7bed1dc41a50c77b::scallop_sui {
    struct SCALLOP_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCALLOP_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCALLOP_SUI>(arg0, 9, b"sSUI", b"sSUI", b"Scallop interest-bearing token for SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kedklfyxuzixrtdeqtieu6g5u7sbrcjr5cgyysbx63mmowgfrfiq.arweave.net/UQallxemUXjMZITQSnjdp-QYiTHojYxIN_bYx1jFiVE")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCALLOP_SUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCALLOP_SUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

