module 0x10e7c1b087f61e55bb5de6ecba8aaed85212a4dd041b73d34dbc7038bebd0487::suinaldo {
    struct SUINALDO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINALDO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINALDO>(arg0, 9, b"SUINALDO", b"Suinaldo", b"GOAT COIN BY SPEED N RONALDO  https://www.suinaldo.fun/   https://x.com/suinaldoonsui  https://t.me/suinaldohomepage", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1728738875903-b78763e04529f59c29c5244efe3c4639.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUINALDO>(&mut v2, 150000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINALDO>>(v2, @0x6977722118b501b4eac0174c6b8eeca3caa2edd6e88717f3f8620b0cd39fdb3d);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINALDO>>(v1);
    }

    // decompiled from Move bytecode v6
}

