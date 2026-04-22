module 0xcbd7fa17e24d5faf94902045a4e2559cb4b823207ae337e0261e4a41deb74ea5::baby_black_dragon {
    struct BABY_BLACK_DRAGON has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABY_BLACK_DRAGON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABY_BLACK_DRAGON>(arg0, 9, b"BBD", b"Baby Black Dragon", b"Baby black dragon on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1776873705894-ecb9228af53158945bd794bc0461ab78.png"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<BABY_BLACK_DRAGON>>(0x2::coin::mint<BABY_BLACK_DRAGON>(&mut v2, 10000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BABY_BLACK_DRAGON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABY_BLACK_DRAGON>>(v2, @0x0);
    }

    // decompiled from Move bytecode v7
}

