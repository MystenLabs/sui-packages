module 0xd5b0b8380487d974cf51ad9224ba184b4d61fdfe8a41cbcb9fd1417eebfaf842::pooppoo {
    struct POOPPOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: POOPPOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POOPPOO>(arg0, 9, b"POOPPOO", b"Pooppoo Coin", b"Telegram On Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1776351127298-1f868f31d7bb9b00f86cad27759faf95.png"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<POOPPOO>>(0x2::coin::mint<POOPPOO>(&mut v2, 10000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POOPPOO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POOPPOO>>(v2, @0x0);
    }

    // decompiled from Move bytecode v7
}

