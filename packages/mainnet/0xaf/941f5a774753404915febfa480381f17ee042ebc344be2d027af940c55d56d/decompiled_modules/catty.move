module 0xaf941f5a774753404915febfa480381f17ee042ebc344be2d027af940c55d56d::catty {
    struct CATTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATTY>(arg0, 9, b"CATTY", b"Catty", b"catty on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1776273807416-48d45732bc0b2d3bdd92f1ccb257f958.png"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<CATTY>>(0x2::coin::mint<CATTY>(&mut v2, 10000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CATTY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATTY>>(v2, @0x0);
    }

    // decompiled from Move bytecode v7
}

