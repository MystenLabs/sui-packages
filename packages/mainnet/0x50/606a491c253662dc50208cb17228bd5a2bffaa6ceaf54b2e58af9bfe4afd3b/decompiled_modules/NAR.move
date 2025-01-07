module 0x50606a491c253662dc50208cb17228bd5a2bffaa6ceaf54b2e58af9bfe4afd3b::NAR {
    struct NAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAR>(arg0, 8, b"NAR", b"Narwhal", b"An adorably oblivious narwhal who's always making waves in the deep sea, riding through chaos with a goofy grin!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://asset.suinarwhal.fun/narwhal.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NAR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<NAR>>(0x2::coin::mint<NAR>(&mut v2, 100000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<NAR>>(v2);
    }

    // decompiled from Move bytecode v6
}

