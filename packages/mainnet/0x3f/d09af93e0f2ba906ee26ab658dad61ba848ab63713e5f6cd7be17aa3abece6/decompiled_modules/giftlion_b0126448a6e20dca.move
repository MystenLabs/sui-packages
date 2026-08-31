module 0x3fd09af93e0f2ba906ee26ab658dad61ba848ab63713e5f6cd7be17aa3abece6::giftlion_b0126448a6e20dca {
    struct GIFTLION_B0126448A6E20DCA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GIFTLION_B0126448A6E20DCA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GIFTLION_B0126448A6E20DCA>(arg0, 0, b"GIFTLION", b"giftlion", b"Bluegift's official token, giftlion", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suigift.fun/api/uploads/token-icons/1788189236554-1593c34e-fe86-471c-a5cf-5bedd8180e48.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GIFTLION_B0126448A6E20DCA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<GIFTLION_B0126448A6E20DCA>>(0x2::coin::mint<GIFTLION_B0126448A6E20DCA>(&mut v2, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GIFTLION_B0126448A6E20DCA>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

