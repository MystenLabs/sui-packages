module 0x823c4be0b7956f7777de7f6215d4ec357aa9634af7e61c8f7f0e4fe544e7f9ea::scat {
    struct SCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCAT>(arg0, 6, b"SCAT", b"SuiCatalorian", b" SUICATALORIAN PROTECTING THE UNIVERSE FROM ALIENS!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SCAT_bc4b452495.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

