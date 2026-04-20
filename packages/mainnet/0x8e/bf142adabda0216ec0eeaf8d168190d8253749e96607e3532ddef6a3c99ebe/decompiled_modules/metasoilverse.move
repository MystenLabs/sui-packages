module 0x8ebf142adabda0216ec0eeaf8d168190d8253749e96607e3532ddef6a3c99ebe::metasoilverse {
    struct METASOILVERSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: METASOILVERSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<METASOILVERSE>(arg0, 9, b"MSVP", b"MetaSoilVerse Protocol", b"MetasoilVerse Protocol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1776704749594-90395c39f63ddbd5a20acdcbe111c1f0.png"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<METASOILVERSE>>(0x2::coin::mint<METASOILVERSE>(&mut v2, 10000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<METASOILVERSE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<METASOILVERSE>>(v2, @0x0);
    }

    // decompiled from Move bytecode v7
}

