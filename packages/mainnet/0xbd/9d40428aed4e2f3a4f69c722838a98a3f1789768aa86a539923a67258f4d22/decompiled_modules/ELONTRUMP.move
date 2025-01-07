module 0xbd9d40428aed4e2f3a4f69c722838a98a3f1789768aa86a539923a67258f4d22::ELONTRUMP {
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

