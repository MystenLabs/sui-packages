module 0xf5c04ba74c301fda117fe618e5c25154c8c476f95fe7823c9dd06b16c19f3acf::ginnan {
    struct GINNAN has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<GINNAN>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<GINNAN>>(0x2::coin::mint<GINNAN>(arg0, arg2 * 1000000000, arg3), arg1);
    }

    fun init(arg0: GINNAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GINNAN>(arg0, 9, b"GINNAN", b"GINNAN", b"Most famous upcoming cat related to the best dog in meme world!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1825480037186838528/C7tKLAv9_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GINNAN>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GINNAN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GINNAN>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

