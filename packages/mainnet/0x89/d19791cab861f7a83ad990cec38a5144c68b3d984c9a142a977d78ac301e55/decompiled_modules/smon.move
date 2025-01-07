module 0x89d19791cab861f7a83ad990cec38a5144c68b3d984c9a142a977d78ac301e55::smon {
    struct SMON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMON>(arg0, 6, b"SMON", b"Suimon", b"Suimon great pokemon ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Sn4_Yjwbo_AA_3o_OM_f5916b6b69.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMON>>(v1);
    }

    // decompiled from Move bytecode v6
}

