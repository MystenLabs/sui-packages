module 0x819ec563b75feaa7155330bb85d1aeeb64200b28f8b71e9fb3753897e6cc130c::joiby {
    struct JOIBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOIBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOIBY>(arg0, 9, b"JOIBY", b"Joiby", b"Joiby is the original cute mascot of the Sui blockchain ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdna.artstation.com/p/assets/images/images/080/426/526/large/romart3d-girl-in-yelow-light-r1.jpg?1727542253")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<JOIBY>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOIBY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JOIBY>>(v1);
    }

    // decompiled from Move bytecode v6
}

