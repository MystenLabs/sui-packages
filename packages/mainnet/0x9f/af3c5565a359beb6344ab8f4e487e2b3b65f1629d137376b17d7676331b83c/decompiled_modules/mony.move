module 0x9faf3c5565a359beb6344ab8f4e487e2b3b65f1629d137376b17d7676331b83c::mony {
    struct MONY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONY>(arg0, 9, b"MONY", b"MooMoney", b"MooMoney (MONY) is a fun, eco-friendly token supporting green initiatives and sustainable farming.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1766130383425343488/tSOyeRHL.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MONY>(&mut v2, 700000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MONY>>(v1);
    }

    // decompiled from Move bytecode v6
}

