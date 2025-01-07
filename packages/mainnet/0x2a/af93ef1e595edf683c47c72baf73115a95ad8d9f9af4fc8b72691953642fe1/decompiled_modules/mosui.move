module 0x2aaf93ef1e595edf683c47c72baf73115a95ad8d9f9af4fc8b72691953642fe1::mosui {
    struct MOSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOSUI>(arg0, 9, b"MOSUI INU", b"MOSUI", b"Blue frriendly meme token on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.imgur.com/kDAOEcQ.jpeg"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOSUI>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MOSUI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOSUI>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

