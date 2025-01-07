module 0x540664c7e59feb73158af2296887e4fbec0b379b5868977901846a484e103319::KAMALA4SIU {
    struct KAMALA4SIU has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAMALA4SIU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAMALA4SIU>(arg0, 6, b"KAMALA4SIU", b"KAMALA4SIU", b"LFFFFGGGGGGG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.imgur.com/b6h8Bm6.jpeg"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<KAMALA4SIU>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAMALA4SIU>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KAMALA4SIU>>(v1);
    }

    // decompiled from Move bytecode v6
}

