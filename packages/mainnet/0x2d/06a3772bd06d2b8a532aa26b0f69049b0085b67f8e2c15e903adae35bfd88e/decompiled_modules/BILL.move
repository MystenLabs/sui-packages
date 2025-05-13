module 0x2d06a3772bd06d2b8a532aa26b0f69049b0085b67f8e2c15e903adae35bfd88e::BILL {
    struct BILL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BILL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BILL>(arg0, 6, b"BILL", b"Bull Bill", b"Dolla dolla bill on a bull #bullish", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://uptos-pump.myfilebase.com/ipfs/QmV7F2gx8tkGXrmCTNVdibzqg9V1DD5uAkSrGx4KLsoiJJ")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BILL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BILL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

