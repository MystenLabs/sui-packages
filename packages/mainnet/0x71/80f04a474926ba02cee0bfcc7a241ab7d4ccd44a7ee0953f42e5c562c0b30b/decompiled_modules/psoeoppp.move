module 0x7180f04a474926ba02cee0bfcc7a241ab7d4ccd44a7ee0953f42e5c562c0b30b::psoeoppp {
    struct PSOEOPPP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PSOEOPPP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PSOEOPPP>(arg0, 6, b"PSOEOPPP", b"psoeoppp", b"psoeoppp", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PSOEOPPP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<PSOEOPPP>>(0x2::coin::mint<PSOEOPPP>(&mut v2, 210000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PSOEOPPP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

