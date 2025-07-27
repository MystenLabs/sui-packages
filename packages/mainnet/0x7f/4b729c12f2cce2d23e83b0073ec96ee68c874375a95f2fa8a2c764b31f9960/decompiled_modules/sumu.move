module 0x7f4b729c12f2cce2d23e83b0073ec96ee68c874375a95f2fa8a2c764b31f9960::sumu {
    struct SUMU has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUMU>, arg1: 0x2::coin::Coin<SUMU>) {
        0x2::coin::burn<SUMU>(arg0, arg1);
    }

    public entry fun destroy_treasury_cap(arg0: 0x2::coin::TreasuryCap<SUMU>) {
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUMU>>(arg0, @0x0);
    }

    fun init(arg0: SUMU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUMU>(arg0, 6, b"SUMU", b"SUMU THE BULL", b"$SUMU is the official mascot of the SUI bull market - a memecoin powered by unstoppable momentum, herd energy, and full-on bull vibes. Born to charge, SUMU leads the stampede with a mission to unite the SUI ecosystem under one bullish banner.This is more than a token. This is a movement.The SUI Bull has arrived. Join the stampede.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/ELtUxJr.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUMU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUMU>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUMU>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUMU>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

