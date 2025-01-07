module 0xe7f12084297882edb0e511578cac1902e4c66eed83e2895ff53401d5e0c0fecd::capycook {
    struct CAPYCOOK has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAPYCOOK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAPYCOOK>(arg0, 9, b"CAPYCOOK", b"CAPY COOK", b"HOLD UP! LET CAPYBARA COOK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4dd3d30a-532c-4ac2-b544-db38dc807309.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAPYCOOK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CAPYCOOK>>(v1);
    }

    // decompiled from Move bytecode v6
}

