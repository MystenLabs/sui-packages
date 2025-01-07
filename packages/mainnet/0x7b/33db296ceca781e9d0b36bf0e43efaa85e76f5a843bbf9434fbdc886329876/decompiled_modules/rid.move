module 0x7b33db296ceca781e9d0b36bf0e43efaa85e76f5a843bbf9434fbdc886329876::rid {
    struct RID has drop {
        dummy_field: bool,
    }

    fun init(arg0: RID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RID>(arg0, 9, b"RID", b"HD", b"Good", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5c750177-88d1-4f59-a78c-7cb912ba152b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RID>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RID>>(v1);
    }

    // decompiled from Move bytecode v6
}

