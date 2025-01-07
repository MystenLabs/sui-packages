module 0xe5d2289dbce57b0bde1f17bc9f660b095a157e72ffe50dd177354e2809675049::bubu {
    struct BUBU has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUBU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUBU>(arg0, 9, b"BUBU", b"Bubu the Bear", b"I'm so happy cause i'm a gummy bear, gummy bear... aaaaaaaa...", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BUBU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUBU>>(v0, 0x2::tx_context::sender(arg1));
    }

    entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BUBU>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<BUBU>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

