module 0xd2223aea40419c518673de4f93a6b5ebb390e12e2fafeaa9af6866ba71459e8b::mkrabs {
    struct MKRABS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MKRABS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MKRABS>(arg0, 6, b"MKrabs", b"Mr.MKrabs", b"Mr. Krabs, who is in the deep sea burger restaurant, should go bankrupt and enter the SUI ecosystem to continue his business, and he sent a message to those who failed to work as workers.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/e_e_ae_a_c_7f56968dad.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MKRABS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MKRABS>>(v1);
    }

    // decompiled from Move bytecode v6
}

