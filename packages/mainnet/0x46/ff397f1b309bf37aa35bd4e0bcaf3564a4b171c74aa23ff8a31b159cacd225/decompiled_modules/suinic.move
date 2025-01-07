module 0x46ff397f1b309bf37aa35bd4e0bcaf3564a4b171c74aa23ff8a31b159cacd225::suinic {
    struct SUINIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINIC>(arg0, 6, b"SUINIC", b"Suinic", b"Suinic is the Fastest bringing a new wave of excitement to the crypto space. The Suinic project is an innovative initiative built on the SUI network, a blockchain designed for high efficiency and optimal scalability.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suinic_logo_bulet_809d9aac86.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINIC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINIC>>(v1);
    }

    // decompiled from Move bytecode v6
}

