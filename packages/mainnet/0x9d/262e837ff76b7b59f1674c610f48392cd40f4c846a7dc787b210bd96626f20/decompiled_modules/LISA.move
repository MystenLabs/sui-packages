module 0x9d262e837ff76b7b59f1674c610f48392cd40f4c846a7dc787b210bd96626f20::LISA {
    struct LISA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LISA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LISA>(arg0, 6, b"LISA", b"Lisa Simpson", b"loserrrr", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://uptos-pump.myfilebase.com/ipfs/QmSGhnBVL6v8zJ5PHKerbY85KtL7acijfNTQsYCY2aGyyV")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LISA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LISA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

