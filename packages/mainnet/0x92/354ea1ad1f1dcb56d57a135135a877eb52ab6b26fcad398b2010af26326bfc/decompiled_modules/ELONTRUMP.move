module 0x92354ea1ad1f1dcb56d57a135135a877eb52ab6b26fcad398b2010af26326bfc::ELONTRUMP {
    struct ELONTRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELONTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELONTRUMP>(arg0, 6, b"ELONTRUMP", b"ELONTRUMP", b"Find Our Community On Discord", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.imgur.com/AISSlQJ.jpeg"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ELONTRUMP>(&mut v2, 200000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELONTRUMP>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ELONTRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

