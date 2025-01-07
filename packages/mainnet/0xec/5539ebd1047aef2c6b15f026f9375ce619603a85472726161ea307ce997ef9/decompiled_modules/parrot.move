module 0xec5539ebd1047aef2c6b15f026f9375ce619603a85472726161ea307ce997ef9::parrot {
    struct PARROT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PARROT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PARROT>(arg0, 9, b"PARROT", b"Party Parrot", b"Cult of the Party Parrot", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bafkreibrjwfiobjdiwaakr6qinhxqhyxfdjvdjbbsjricbbehw7h7vfv2u.ipfs.w3s.link")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PARROT>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PARROT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PARROT>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

