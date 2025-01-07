module 0x37d2467cbb2b855f356528461911517b49ccd74315f22c36f5dc11f68f3bb7da::russell {
    struct RUSSELL has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUSSELL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUSSELL>(arg0, 9, b"RUSSELL", b"RUSSELL", b"PIGU1", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSksYLP_Xnq6Y-vFV5_n5w3bhXkG0TxaDxXpQ&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<RUSSELL>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUSSELL>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RUSSELL>>(v1);
    }

    // decompiled from Move bytecode v6
}

