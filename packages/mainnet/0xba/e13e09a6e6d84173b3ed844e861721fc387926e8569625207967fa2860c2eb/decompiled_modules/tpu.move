module 0xbae13e09a6e6d84173b3ed844e861721fc387926e8569625207967fa2860c2eb::tpu {
    struct TPU has drop {
        dummy_field: bool,
    }

    fun init(arg0: TPU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TPU>(arg0, 9, b"TPU", b"First bitcoin kid", b"This is the first kid to EVER talk about bitcoin back in 2011", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmatJ7HerN7r8HrSHKVkTMbes6mgdXKJ1EeW9uRpa8a3uQ")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TPU>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TPU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TPU>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

