module 0x750d88c0d8915e31030f378b947e40026dcf9d0b9867d9a9783efce372deb659::suigangs {
    struct SUIGANGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGANGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGANGS>(arg0, 6, b"SuiGangs", b"SUI Network Gangsters", b"SUI GANGS has forged strategic partnerships with leading companies in the crypto space, which will help to ensure the project's long-term viability and growth", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Hi7o_RL_Mh_400x400_a9ae877889.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGANGS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGANGS>>(v1);
    }

    // decompiled from Move bytecode v6
}

