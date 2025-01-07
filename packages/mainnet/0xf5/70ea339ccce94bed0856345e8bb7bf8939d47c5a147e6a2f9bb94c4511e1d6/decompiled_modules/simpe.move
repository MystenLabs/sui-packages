module 0xf570ea339ccce94bed0856345e8bb7bf8939d47c5a147e6a2f9bb94c4511e1d6::simpe {
    struct SIMPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIMPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIMPE>(arg0, 6, b"SIMPE", b"Sim Pepe Yellow", b"Welcome to the wild side of yellow!SimPepe Yellow - where the Simpsons meet Pepe in a meme-tastic explosion.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4_T_Bsvkw_400x400_cbe3825fa9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIMPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIMPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

