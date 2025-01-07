module 0xcf1141d0ad132a60de10499514b59992b59ebfee37a46ae8f2412f387ae80c1c::adwe {
    struct ADWE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADWE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADWE>(arg0, 9, b"ADWE", b"Adawewe", b"My own", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5ae6d889-7853-4723-b332-ac6acb35fded.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADWE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ADWE>>(v1);
    }

    // decompiled from Move bytecode v6
}

