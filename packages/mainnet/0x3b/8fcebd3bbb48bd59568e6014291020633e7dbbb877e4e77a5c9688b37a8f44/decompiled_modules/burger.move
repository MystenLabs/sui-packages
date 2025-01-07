module 0x3b8fcebd3bbb48bd59568e6014291020633e7dbbb877e4e77a5c9688b37a8f44::burger {
    struct BURGER has drop {
        dummy_field: bool,
    }

    fun init(arg0: BURGER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BURGER>(arg0, 6, b"BURGER", b"CRYPTO BURGER", b"Crypto Burger - The first $BURGER on SUI Former US President Trump once again bought a burger with BTC! To commemorate this milestone, the burger \"BURGER\" that is engraved in the history of cryptocurrencies came into being", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/BURGER_T_Dbhi_U_7ti5r_U_Aq_Ru_NJ_f555571c25.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BURGER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BURGER>>(v1);
    }

    // decompiled from Move bytecode v6
}

