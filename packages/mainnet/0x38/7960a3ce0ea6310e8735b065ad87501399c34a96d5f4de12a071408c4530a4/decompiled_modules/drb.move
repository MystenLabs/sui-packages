module 0x387960a3ce0ea6310e8735b065ad87501399c34a96d5f4de12a071408c4530a4::drb {
    struct DRB has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRB>(arg0, 9, b"DRB", b"Doctor Bak", b"To the Moon and the back ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/76644c60-d536-4f69-ac8c-5e2fabc8ae61.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DRB>>(v1);
    }

    // decompiled from Move bytecode v6
}

