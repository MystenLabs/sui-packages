module 0xd840515525e824b9a10547a12744c3c5a87f08c8acb1eb4c329c0023f1cb3be7::tape {
    struct TAPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TAPE>(arg0, 9, b"TAPE", b"TAPE", b"Tall and pully Eagle", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTxmjamsfdHet_hSpCTGZ9lRQvnzkDohT3j6Q&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TAPE>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAPE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TAPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

