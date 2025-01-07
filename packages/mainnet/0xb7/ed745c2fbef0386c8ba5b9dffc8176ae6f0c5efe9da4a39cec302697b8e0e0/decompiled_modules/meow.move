module 0xb7ed745c2fbef0386c8ba5b9dffc8176ae6f0c5efe9da4a39cec302697b8e0e0::meow {
    struct MEOW has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MEOW>, arg1: 0x2::coin::Coin<MEOW>) {
        0x2::coin::burn<MEOW>(arg0, arg1);
    }

    fun init(arg0: MEOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<MEOW>(arg0, 9, b"MEOW", b"Meow The Cat", b"Come meow with us, Meow Meow The Cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/cbLBttn/sleeping-meowcat-NOT.png")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<MEOW>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEOW>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MEOW>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<MEOW>>(v1, @0x6d1d91b43043d325993e1194bd18bd67e454dd98777bb1eae112d696676b85c0);
    }

    public fun migrate_currency_to_v2(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<MEOW>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<MEOW>(arg0, arg1, arg2, arg3);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MEOW>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MEOW>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

