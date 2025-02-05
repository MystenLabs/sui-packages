module 0x522e6be94c196559c2859c4de9ff9a95b61b3b6bee343b8e6e069d6fbd910de7::chems {
    struct CHEMS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHEMS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHEMS>(arg0, 9, b"CHEMS", b"CHEMS Token", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT_EavwKERmVAm-8nDKnd8PrCO1sXhyVpLyPA&s"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CHEMS>(&mut v2, 1000000000000000000, @0x4ff800c3dc2521daf8061423388c078903c717cf462b4812f799cfdeda703d33, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHEMS>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<CHEMS>>(v2);
    }

    // decompiled from Move bytecode v6
}

