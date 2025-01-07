module 0x8671c821650562140ab0628ced1ac71a65ecb5710f86c4b60b2cf13d843361ea::suiiieee {
    struct SUIIIEEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIIIEEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIIIEEE>(arg0, 6, b"Suiiieee", b"Suiiieee ... Cutest coin on Sui", b"Suiiieee, ... hugs anyone?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suiiieee_99b305fc99.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIIIEEE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIIIEEE>>(v1);
    }

    // decompiled from Move bytecode v6
}

