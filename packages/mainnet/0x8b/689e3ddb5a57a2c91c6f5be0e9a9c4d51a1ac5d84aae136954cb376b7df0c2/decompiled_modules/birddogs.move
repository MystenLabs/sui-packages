module 0x8b689e3ddb5a57a2c91c6f5be0e9a9c4d51a1ac5d84aae136954cb376b7df0c2::birddogs {
    struct BIRDDOGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIRDDOGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIRDDOGS>(arg0, 6, b"BIRDDOGS", b"BirddogsOnSui", b"$DGB IS A MEME COIN ON SUI BLOCKCHAIN WITH NEW FEATURE AND UTILITY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000145_72382f4cb9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIRDDOGS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BIRDDOGS>>(v1);
    }

    // decompiled from Move bytecode v6
}

