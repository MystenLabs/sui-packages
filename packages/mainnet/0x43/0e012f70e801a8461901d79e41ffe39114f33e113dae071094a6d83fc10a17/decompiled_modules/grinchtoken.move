module 0x430e012f70e801a8461901d79e41ffe39114f33e113dae071094a6d83fc10a17::grinchtoken {
    struct GRINCHTOKEN has drop {
        dummy_field: bool,
    }

    struct Analytics has store, key {
        id: 0x2::object::UID,
        total_burned: u64,
        total_transferred: u64,
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<GRINCHTOKEN>, arg1: &mut 0x2::coin::TreasuryCap<GRINCHTOKEN>, arg2: &mut 0x2::table::Table<u64, Analytics>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        transfer_with_fee(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun burn_tokens(arg0: &mut 0x2::coin::TreasuryCap<GRINCHTOKEN>, arg1: &mut 0x2::table::Table<u64, Analytics>, arg2: 0x2::coin::Coin<GRINCHTOKEN>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<GRINCHTOKEN>(arg0, arg2);
        let v0 = 0x2::table::borrow_mut<u64, Analytics>(arg1, 0);
        v0.total_burned = v0.total_burned + 0x2::coin::value<GRINCHTOKEN>(&arg2);
    }

    public fun create_analytics_table(arg0: &mut 0x2::tx_context::TxContext) : 0x2::table::Table<u64, Analytics> {
        let v0 = 0x2::table::new<u64, Analytics>(arg0);
        let v1 = Analytics{
            id                : 0x2::object::new(arg0),
            total_burned      : 0,
            total_transferred : 0,
        };
        0x2::table::add<u64, Analytics>(&mut v0, 0, v1);
        v0
    }

    public fun get_analytics(arg0: &0x2::table::Table<u64, Analytics>) : (u64, u64) {
        let v0 = 0x2::table::borrow<u64, Analytics>(arg0, 0);
        (v0.total_burned, v0.total_transferred)
    }

    fun init(arg0: GRINCHTOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRINCHTOKEN>(arg0, 3, b"GrinchToken", b"GRINCH", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bafybeiarlnbfn5jgb4ms4yjy4b6um7d6ueuhhnbvkqbsup276ro5cutj24.ipfs.w3s.link/g1.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GRINCHTOKEN>>(v1);
        0x2::coin::mint_and_transfer<GRINCHTOKEN>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRINCHTOKEN>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun transfer_with_fee(arg0: 0x2::coin::Coin<GRINCHTOKEN>, arg1: &mut 0x2::coin::TreasuryCap<GRINCHTOKEN>, arg2: &mut 0x2::table::Table<u64, Analytics>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<GRINCHTOKEN>(&arg0);
        let v1 = v0 / 1000;
        0x2::coin::burn<GRINCHTOKEN>(arg1, 0x2::coin::split<GRINCHTOKEN>(&mut arg0, v1, arg4));
        let v2 = 0x2::table::borrow_mut<u64, Analytics>(arg2, 0);
        v2.total_burned = v2.total_burned + v1;
        v2.total_transferred = v2.total_transferred + v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<GRINCHTOKEN>>(arg0, arg3);
    }

    // decompiled from Move bytecode v6
}

