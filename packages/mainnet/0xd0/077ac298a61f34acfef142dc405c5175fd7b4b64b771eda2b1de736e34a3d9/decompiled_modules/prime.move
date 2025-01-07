module 0xd0077ac298a61f34acfef142dc405c5175fd7b4b64b771eda2b1de736e34a3d9::prime {
    struct PRIME has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<PRIME>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PRIME>>(0x2::coin::mint<PRIME>(arg0, arg2 * 1000000000, arg3), arg1);
    }

    fun init(arg0: PRIME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRIME>(arg0, 9, b"PRIME", b"PRIME", b"PRIME token a innovation of Ai with shilling and posting, generating images and reels with graphic beyond expectations.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1742195772131622912/Ckc1hMH5_400x400.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PRIME>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PRIME>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRIME>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

