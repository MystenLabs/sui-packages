module 0xe85b56786f7fc728950dbd53a70f466e4073b744e9d6fcce03bbdc92c55710e4::enzo {
    struct ENZO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ENZO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ENZO>(arg0, 9, b"ENZO", b"Enzo", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.tbstat.com/wp/uploads/2023/10/sui_asset.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ENZO>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ENZO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ENZO>>(v1);
    }

    // decompiled from Move bytecode v6
}

