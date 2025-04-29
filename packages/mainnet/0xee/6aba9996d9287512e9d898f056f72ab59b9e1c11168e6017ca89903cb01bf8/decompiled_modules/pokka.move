module 0xee6aba9996d9287512e9d898f056f72ab59b9e1c11168e6017ca89903cb01bf8::pokka {
    struct POKKA has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<POKKA>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<POKKA>>(0x2::coin::mint<POKKA>(arg0, arg2 * 1000000000, arg3), arg1);
    }

    fun init(arg0: POKKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POKKA>(arg0, 9, b"POKKA", b"POKKA", b"POKKA the Ai girl autonomous a sweetheart, but yet a tough blue chick going into amazing ammount of data giving you real Alpha", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1622596719434407936/kichVAjx_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<POKKA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POKKA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POKKA>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

