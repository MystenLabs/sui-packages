module 0x320db476fbd226d68915f56440f601ae1c61ff4d2d54903b2c072097297cbe2e::aztiri {
    struct AZTIRI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AZTIRI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AZTIRI>(arg0, 9, b"AZTIRI", b"Aztiri", b"Vampire Hunter Aztiri", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdna.artstation.com/p/assets/images/images/080/672/048/large/choi-hye-rim-heart04.jpg?1728221583")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AZTIRI>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AZTIRI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AZTIRI>>(v1);
    }

    // decompiled from Move bytecode v6
}

