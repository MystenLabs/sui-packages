module 0x8023ccb94789ae255ec95ee86ef70451d2f018df5a32fef685bea3a10c40b70::rct {
    struct RCT has drop {
        dummy_field: bool,
    }

    fun init(arg0: RCT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RCT>(arg0, 9, b"RCT", b"Roccat", b"Roccat to the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/93f8de95-bd40-4e61-84e2-56964eedf234.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RCT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RCT>>(v1);
    }

    // decompiled from Move bytecode v6
}

