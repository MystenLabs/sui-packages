module 0x9904ff70ac3e05f360e6ca30df58a40c264546575ec584ea0bdb7e494cde7717::fff {
    struct FFF has drop {
        dummy_field: bool,
    }

    public(friend) fun create_url(arg0: vector<u8>) : 0x2::url::Url {
        0x2::url::new_unsafe(0x1::ascii::string(arg0))
    }

    fun init(arg0: FFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FFF>(arg0, 9, b"FFF", b"FFF Token", b"ffg", 0x1::option::some<0x2::url::Url>(create_url(b"ffh")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<FFF>>(0x2::coin::mint<FFF>(&mut v2, 6969 * 1000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FFF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FFF>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

