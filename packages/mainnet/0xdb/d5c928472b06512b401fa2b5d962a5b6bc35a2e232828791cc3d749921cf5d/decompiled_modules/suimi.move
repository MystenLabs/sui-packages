module 0xdbd5c928472b06512b401fa2b5d962a5b6bc35a2e232828791cc3d749921cf5d::suimi {
    struct SUIMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMI>(arg0, 6, b"suimi", b"SUIMI", b"SUIMI is a really cool token.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.ibb.co/vxdhqvV/Sans-titre-106-20241007122557.png"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIMI>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

