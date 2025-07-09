module 0xf6cfe9da09040d11800eba949eb0cb9a459a660fc0d50514289a6c534455023a::stest {
    struct STEST has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<STEST>, arg1: 0x2::coin::Coin<STEST>) {
        0x2::coin::burn<STEST>(arg0, arg1);
    }

    public entry fun destroy_treasury_cap(arg0: 0x2::coin::TreasuryCap<STEST>) {
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEST>>(arg0, @0x0);
    }

    fun init(arg0: STEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEST>(arg0, 6, b"STEST", b"Sui Test", b"nice test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/mW3y4mo.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STEST>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEST>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<STEST>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<STEST>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

