module 0xa771854aa005a333a93bdf90f481527523369baab009cf4553c6c328f142c3b6::remilia {
    struct REMILIA has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<REMILIA>, arg1: 0x2::coin::Coin<REMILIA>) {
        0x2::coin::burn<REMILIA>(arg0, arg1);
    }

    fun init(arg0: REMILIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REMILIA>(arg0, 9, b"Remilia", b"Remilia", b"Remilia Cult is the edgy, anonymous art group behind NFT projects Milady Maker & Remilio Babies. Known for blending anime, internet nostalgia, and post-ironic humor, they embrace subcultures like vaporwave & e-girl aesthetics. Controversial yet influential, Remilia challenges art norms while building a dedicated online community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/8wZvGcGePvWEa8tKQUYctMXFSkqS39scozVU9xBVrUjY.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<REMILIA>>(v1);
        0x2::coin::mint_and_transfer<REMILIA>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<REMILIA>>(v2);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<REMILIA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<REMILIA>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

