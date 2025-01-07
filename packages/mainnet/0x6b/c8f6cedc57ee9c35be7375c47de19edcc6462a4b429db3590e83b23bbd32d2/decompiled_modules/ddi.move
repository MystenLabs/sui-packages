module 0x6bc8f6cedc57ee9c35be7375c47de19edcc6462a4b429db3590e83b23bbd32d2::ddi {
    struct DDI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DDI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DDI>(arg0, 9, b"DDI", b"Dice", b"a chance", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ec195846-8e58-42be-a618-f508862b1cb4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DDI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DDI>>(v1);
    }

    // decompiled from Move bytecode v6
}

