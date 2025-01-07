module 0x57813ff18b29b5b2603abf8e1b91551a50c7fd9d60c6526756c8099375d78e9d::grinchtoken {
    struct GRINCHTOKEN has drop {
        dummy_field: bool,
    }

    struct Analytics has store, key {
        id: 0x2::object::UID,
        total_burned: u64,
        total_transferred: u64,
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

    public fun get_token_metadata() : (vector<u8>, vector<u8>, u64) {
        (b"GrinchToken", b"GRINCH", 10000000)
    }

    fun init(arg0: GRINCHTOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        init_internal(arg0, arg1);
    }

    fun init_internal(arg0: GRINCHTOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRINCHTOKEN>(arg0, 3, b"GrinchToken", b"GRINCH", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bafybeidfkub5ien6b4jyretko3mp6jvq53xnoi4mxiprg2gp7j5gzgzsge.ipfs.w3s.link/image.png")), arg1);
        let v2 = v0;
        let v3 = create_analytics_table(arg1);
        0x2::transfer::public_transfer<0x2::table::Table<u64, Analytics>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GRINCHTOKEN>>(v1);
        0x2::coin::mint_and_transfer<GRINCHTOKEN>(&mut v2, 10000000, 0x2::tx_context::sender(arg1), arg1);
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

