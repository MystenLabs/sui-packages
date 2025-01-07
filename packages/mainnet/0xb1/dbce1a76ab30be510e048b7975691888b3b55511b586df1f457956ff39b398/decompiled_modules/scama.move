module 0xb1dbce1a76ab30be510e048b7975691888b3b55511b586df1f457956ff39b398::scama {
    struct SCAMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCAMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCAMA>(arg0, 6, b"Scama", b"Scamasia", x"5363616d20617369610a4d616b652052757373696120677265617420616761696e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/D_D_N_D_D_N_D_2e6ce5c2ac.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCAMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCAMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

