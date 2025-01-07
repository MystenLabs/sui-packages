module 0x17544cbc28a2c1740e5a06723f0d5534bc0e801863fe1d18ca0efde87920b713::ronaldo {
    struct RONALDO has drop {
        dummy_field: bool,
    }

    fun init(arg0: RONALDO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RONALDO>(arg0, 9, b"RONALDO", x"e29abd2053756969696969696969696969", b"Official token of Ronaldo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSfBswuxFP_tzQnmZruwYw0g4iZVaKXAq_J9Q&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<RONALDO>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RONALDO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RONALDO>>(v1);
    }

    // decompiled from Move bytecode v6
}

