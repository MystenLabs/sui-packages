module 0x44d21244e773447594614d32ca768126892032b5cd2b3f614fc6b90eec9b7623::blubercats {
    struct BLUBERCATS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUBERCATS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUBERCATS>(arg0, 9, b"BLUBERCATS", b"Bluber Cats", b"Bluber Cats soon moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1851014062332919811/ooZuquuT.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BLUBERCATS>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUBERCATS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUBERCATS>>(v1);
    }

    // decompiled from Move bytecode v6
}

