module 0xf0419fe5390f8dedba65170e7e0cbf15de39729204930cc4a495a3d97d906521::hcore {
    struct HCORE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HCORE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HCORE>(arg0, 9, b"HCORE", b"HOPECORE ", b"Daily Hopecore content ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2be0c66b-aa2f-40f4-97d4-446400ace9ba.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HCORE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HCORE>>(v1);
    }

    // decompiled from Move bytecode v6
}

