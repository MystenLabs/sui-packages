module 0x1bb97321d448eb1b20541c3f2335b7c1212ec741f9d4799918f70e6f5c03f47a::paul {
    struct PAUL has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<PAUL>, arg1: 0x2::coin::Coin<PAUL>) {
        0x2::coin::burn<PAUL>(arg0, arg1);
    }

    fun init(arg0: PAUL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<PAUL>(arg0, 9, b"PAUL", b"Paul", b"$PAUL the SUi Meme Penguin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/3KcCjt4.jpeg")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<PAUL>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAUL>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PAUL>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<PAUL>>(v1, @0xe9d10503e8d5d11d1a2cc77896be2ff5256bc71ee53455248fe09b03f2c57798);
    }

    public fun migrate_currency_to_v2(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<PAUL>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<PAUL>(arg0, arg1, arg2, arg3);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<PAUL>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<PAUL>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

