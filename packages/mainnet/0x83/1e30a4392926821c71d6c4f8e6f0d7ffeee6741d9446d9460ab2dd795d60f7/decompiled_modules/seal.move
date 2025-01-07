module 0x831e30a4392926821c71d6c4f8e6f0d7ffeee6741d9446d9460ab2dd795d60f7::seal {
    struct SEAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEAL>(arg0, 6, b"SEAL", b"SUI SEAL", b"merely a bored $SEAL in an endless ocean, waiting to become the king of the sea ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/K0_CR_Yc6c_4fd881837b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

