module 0xa125b234275b39b9bd44b3934060856e0bc048de61e921f88b1b9badcf009327::tao {
    struct TAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TAO>(arg0, 9, b"TAO", b"TRUMP", b"okcoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/a22ef418bea3db67554da1b65f5b4ac1blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TAO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

