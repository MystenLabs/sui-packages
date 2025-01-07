module 0x240524fa3416a4a719592c737dabfa4a6365944f7ee0bbf889da263cbae0b256::prick {
    struct PRICK has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRICK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRICK>(arg0, 9, b"PRICK", b"PickleRick", b"I'm Pickle Rick", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c792fd6d-612d-40fb-b6cd-fcb89d6c80dc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRICK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PRICK>>(v1);
    }

    // decompiled from Move bytecode v6
}

