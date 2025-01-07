module 0x40a8d2ca418a45caa15ff4ac5fcfe16bd89554f8c98751806df48afcb159a757::piecake {
    struct PIECAKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIECAKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIECAKE>(arg0, 6, b"PIECAKE", b"PieCake On Sui", b"\"PIESUI, the mystery behind the strange name, is it a secret Secret that will bring luck to those who possess it?\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Wild_5_cbb0e6f6a9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIECAKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIECAKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

