module 0xf06936b1ceaf34571e292cae14a7ab207f4f427cf1d6f3d0b676d67770edf639::chemp {
    struct CHEMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHEMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHEMP>(arg0, 9, b"CHEMP", b"Champions", b"Fun token of champions ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fbf4b9ff-937c-412a-9944-ed859a2b282a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHEMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHEMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

