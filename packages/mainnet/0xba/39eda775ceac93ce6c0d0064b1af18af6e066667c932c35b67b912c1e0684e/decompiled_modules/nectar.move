module 0xafdab633a963fbd8dc956163b07471611acdad841e028cd02af1bfc0fa8486a3::nectar {
    struct NECTAR has drop {
        dummy_field: bool,
    }

    public entry fun burn_coin(arg0: &mut 0x2::coin::TreasuryCap<NECTAR>, arg1: 0x2::coin::Coin<NECTAR>) {
        0x2::coin::burn<NECTAR>(arg0, arg1);
    }

    fun init(arg0: NECTAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NECTAR>(arg0, 8, b"NECTAR", b"NECTAR", b"Nectar tokens are sent by one Wild Channel to another", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmVbXZbGACjjadkDQES2UKQwnMnbCgE5kfPXWmHpWdwHis"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NECTAR>(&mut v2, 12000000000000000000, @0x1620bc616589bd3c5630acb77a7276db1c87ce26deef920aabb3cfd6c2225add, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NECTAR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NECTAR>>(v2, @0x1620bc616589bd3c5630acb77a7276db1c87ce26deef920aabb3cfd6c2225add);
    }

    // decompiled from Move bytecode v6
}

