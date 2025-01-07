module 0x5d68142ffb3a7cd88a544d9180783da60d85fd585ab573d271db4b12ee5fa095::batcat {
    struct BATCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BATCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BATCAT>(arg0, 6, b"BATCAT", b"BATCAT AI", b"AI Anti Scam Tools.On a mission to fight scammers and rugpullers on Sui,Solana and other Blockchains. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Mxyi_G_Zo_M_400x400_78c514ca1a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BATCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BATCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

