module 0xa132a70d0f6bee42f69a6239312f292c32378e6424d423ecc26ad94bc9212b5e::suimoncat {
    struct SUIMONCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMONCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMONCAT>(arg0, 6, b"SuiMONCAT", b"MONCAT", b"THE FAMOUS MONKEY CAT HAS ARRIVED ON SOLANA! THE VIRAL SENSATION IS HERE TO SWING THROUGH THE BLOCKCHAIN AND PURRRFECT THE ART OF DEGENERICY. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/26_494d5cceac.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMONCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMONCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

