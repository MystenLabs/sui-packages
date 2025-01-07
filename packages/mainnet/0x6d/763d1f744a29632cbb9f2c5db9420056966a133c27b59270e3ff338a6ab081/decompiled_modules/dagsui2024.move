module 0x6d763d1f744a29632cbb9f2c5db9420056966a133c27b59270e3ff338a6ab081::dagsui2024 {
    struct DAGSUI2024 has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAGSUI2024, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAGSUI2024>(arg0, 9, b"DAGSUI2024", b"Dagsui", x"4920616d206d656d65636f696e20617566207375692079616d692079616d6920c397313030", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/32abef9e-30d0-4734-a51b-df215f86ba68-1000060532.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAGSUI2024>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DAGSUI2024>>(v1);
    }

    // decompiled from Move bytecode v6
}

