module 0x3054b2e936608075c90fdcb34fce48bfe3ad188cdaf80b9a605f8bc4a617a6ab::batcat {
    struct BATCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BATCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BATCAT>(arg0, 6, b"BATCAT", b"BATCAT ON SUI", b"AI Anti Scam Tools.On a mission to fight scammers and rugpullers on Sui,Solana and other Blockchains. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Mxyi_G_Zo_M_400x400_de3f293851_8aec91c7c2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BATCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BATCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

