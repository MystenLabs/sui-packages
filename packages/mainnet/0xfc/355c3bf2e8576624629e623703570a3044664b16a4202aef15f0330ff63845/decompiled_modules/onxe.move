module 0xfc355c3bf2e8576624629e623703570a3044664b16a4202aef15f0330ff63845::onxe {
    struct ONXE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ONXE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ONXE>(arg0, 6, b"ONXE", b"ONXE SUI", b"First ONXE on SUI:https://onxeonsui.xyz", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730956162118.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ONXE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ONXE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

