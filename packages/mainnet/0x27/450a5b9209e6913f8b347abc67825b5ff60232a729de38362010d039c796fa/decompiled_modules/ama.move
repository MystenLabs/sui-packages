module 0x27450a5b9209e6913f8b347abc67825b5ff60232a729de38362010d039c796fa::ama {
    struct AMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AMA>(arg0, 9, b"AMA", b"Amanita", b"Just a mushroom", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f1cbaff6-7fe4-4175-af7a-502421b19a7c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

