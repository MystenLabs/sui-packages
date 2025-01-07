module 0x384b3a933394fd05d4081d5c3cda7516fe5e63409b9bc0ca08707fd97be19993::thistest {
    struct THISTEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: THISTEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THISTEST>(arg0, 6, b"ThisTest", b"Test the Coin", b"Greatest on earth", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_new_1_7aa868f757.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THISTEST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<THISTEST>>(v1);
    }

    // decompiled from Move bytecode v6
}

