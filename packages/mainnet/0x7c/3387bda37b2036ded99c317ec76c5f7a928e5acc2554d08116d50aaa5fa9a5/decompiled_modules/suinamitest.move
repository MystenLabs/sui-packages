module 0x7c3387bda37b2036ded99c317ec76c5f7a928e5acc2554d08116d50aaa5fa9a5::suinamitest {
    struct SUINAMITEST has drop {
        field: bool,
    }

    struct SUIMAN has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUINAMITEST>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SUINAMITEST>>(0x2::coin::mint<SUINAMITEST>(arg0, arg1, arg3), arg2);
    }

    public fun initialize(arg0: SUINAMITEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINAMITEST>(arg0, 6, b"suiman", b"Suiman", b"Suiman is a meme token on the Sui, combining the fun of superhero vibes with the power of the Sui blockchain. Powered by the community, it's a lighthearted tribute to crypto culture.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.ibb.co/4Ff8v5f/ava.png"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUINAMITEST>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINAMITEST>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

