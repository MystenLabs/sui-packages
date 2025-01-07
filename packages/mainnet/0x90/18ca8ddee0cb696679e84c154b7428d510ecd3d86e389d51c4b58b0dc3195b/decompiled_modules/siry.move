module 0x9018ca8ddee0cb696679e84c154b7428d510ecd3d86e389d51c4b58b0dc3195b::siry {
    struct SIRY has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SIRY>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SIRY>>(0x2::coin::mint<SIRY>(arg0, arg2 * 1000000000, arg3), arg1);
    }

    fun init(arg0: SIRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIRY>(arg0, 9, b"SIRY", b"SIRY", b"SIRY time is here are you ready for a big gains that are coming with it, AI fully autonomous without any censorship, but polite.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1839753648965926912/npDfJTFq_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SIRY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SIRY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIRY>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

