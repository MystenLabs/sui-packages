module 0x678655c2ff364c570ac529e02ec6aad5ec66a3ccbb3369926fb983dbecc18751::shitface {
    struct SHITFACE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHITFACE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHITFACE>(arg0, 9, b"SHITFACE", b"SHITFACE ON SUI", b"Please don't make fun of me, I am shitfaced.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmedvwrdkfDw2uHvsvo4YQ5J9ZAwCU9rrj16TaJ5cMnfga")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SHITFACE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHITFACE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHITFACE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

