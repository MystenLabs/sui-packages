module 0x2fb91ec8e160bd3993d29bba867ace1470506c1a2bc33e0ef16361c68f6d53c1::btc {
    struct BTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTC>(arg0, 9, b"BTC", b"BTC Token", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRmAbthqVgG7xb7R7zQY0qsFuEmJSRSNUQJ1w&s"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BTC>(&mut v2, 100000000000000000, @0x4ff800c3dc2521daf8061423388c078903c717cf462b4812f799cfdeda703d33, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BTC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTC>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

