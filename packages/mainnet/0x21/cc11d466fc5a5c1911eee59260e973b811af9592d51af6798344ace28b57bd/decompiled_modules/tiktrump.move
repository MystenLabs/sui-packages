module 0x21cc11d466fc5a5c1911eee59260e973b811af9592d51af6798344ace28b57bd::tiktrump {
    struct TIKTRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIKTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TIKTRUMP>(arg0, 9, b"TIKTRUMP", b"TIKTRUMP", b" Prettiest Dog On SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.imgur.com/mOw5GBz.jpeg"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TIKTRUMP>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TIKTRUMP>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIKTRUMP>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

