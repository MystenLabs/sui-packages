module 0x2655ad9e762454ec003d5ca1bfcccfa0ce6b456d60121696b97d54b455985f1d::just {
    struct JUST has drop {
        dummy_field: bool,
    }

    fun init(arg0: JUST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JUST>(arg0, 9, b"JUST", b"JUST DO IT", b"JUST DO IT MAN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://data.textstudio.com/output/sample/animated/3/9/3/5/just-1-5393.gif")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<JUST>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JUST>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JUST>>(v1);
    }

    // decompiled from Move bytecode v6
}

