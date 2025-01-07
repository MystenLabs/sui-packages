module 0xfa0a17a3a8682829e36b342eb9c72e47838eb605d7714a8377a4af38c164a4f::sasha {
    struct SASHA has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SASHA>, arg1: 0x2::coin::Coin<SASHA>) {
        0x2::coin::burn<SASHA>(arg0, arg1);
    }

    fun init(arg0: SASHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SASHA>(arg0, 9, b"Bitcoin Cat", b"SASHA", b"Sasha says hello!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmZBFfFRGTA5cgbhZAeF8ratkewbwQ8iAMQMY2uXDvMkym")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SASHA>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SASHA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SASHA>>(v2, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<SASHA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SASHA>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

