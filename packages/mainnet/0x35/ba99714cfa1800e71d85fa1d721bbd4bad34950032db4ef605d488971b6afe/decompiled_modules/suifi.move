module 0x35ba99714cfa1800e71d85fa1d721bbd4bad34950032db4ef605d488971b6afe::suifi {
    struct SUIFI has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIFI>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SUIFI>>(0x2::coin::mint<SUIFI>(arg0, arg2 * 1000000000, arg3), arg1);
    }

    fun init(arg0: SUIFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIFI>(arg0, 9, b"SUIFI", b"SUIFI", b"Getting ready for the sui meme super cycle with suiFi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1670463708793806849/kv8Mr4cN_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIFI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIFI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIFI>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

