module 0x261732173604f1d256dcdf933d7a395b331bc6995c7f842d84987ab5f1d4665e::oscar_lion {
    struct OSCAR_LION has drop {
        dummy_field: bool,
    }

    fun init(arg0: OSCAR_LION, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OSCAR_LION>(arg0, 9, b"OSCAR", b"Oscar Lion", b"Oscar Lion Meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1775902966089-f5f6249a29672628fda797a7c1f06d5d.png"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<OSCAR_LION>>(0x2::coin::mint<OSCAR_LION>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OSCAR_LION>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OSCAR_LION>>(v2, @0x0);
    }

    // decompiled from Move bytecode v7
}

