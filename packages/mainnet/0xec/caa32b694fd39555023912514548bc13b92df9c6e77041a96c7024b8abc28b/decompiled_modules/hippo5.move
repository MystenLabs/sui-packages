module 0xeccaa32b694fd39555023912514548bc13b92df9c6e77041a96c7024b8abc28b::hippo5 {
    struct HIPPO5 has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIPPO5, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIPPO5>(arg0, 9, b"HIPPO5", b"HIPPO5 Token", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://upload.wikimedia.org/wikipedia/commons/f/f2/Portrait_Hippopotamus_in_the_water.jpg"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HIPPO5>(&mut v2, 100000000000000000, @0x4ff800c3dc2521daf8061423388c078903c717cf462b4812f799cfdeda703d33, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HIPPO5>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIPPO5>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

