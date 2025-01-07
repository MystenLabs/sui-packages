module 0xad775ba51a28f86f08a8100b6c7895a20d7a7ecce7b10be54bc44872837a77e7::dino {
    struct DINO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DINO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DINO>(arg0, 9, b"DINO", b"DINO", b"Dino on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://telegra.ph/file/bedcf8608f1cdcb21e70b.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DINO>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DINO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DINO>>(v1);
    }

    // decompiled from Move bytecode v6
}

