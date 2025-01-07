module 0x92eecb05d338f391f7754acf379d186f4fb46eebc1b44570700f0e6055183cf5::bouncecat {
    struct BOUNCECAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOUNCECAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOUNCECAT>(arg0, 6, b"BOUNCECAT", b"Bounce Cat", b"Make Cats boucing on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Capture_da_A_cran_2024_10_12_143121_80e7b5518a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOUNCECAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOUNCECAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

