module 0xccb8cf3645157e4572ee8e2e5451a0431ca767ff3f18a539d11ffcc0f681b8f3::bucket_mock {
    struct BUCKET_MOCK has drop {
        dummy_field: bool,
    }

    struct BuckTreasury has key {
        id: 0x2::object::UID,
        cap: 0x2::coin::TreasuryCap<BUCKET_MOCK>,
    }

    struct CDP has store, key {
        id: 0x2::object::UID,
        collateral: u64,
        debt: u64,
        owner: address,
    }

    public fun check_cdp_owner(arg0: &CDP, arg1: address) : bool {
        arg0.owner == arg1
    }

    public fun create_mock_cdp(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : CDP {
        CDP{
            id         : 0x2::object::new(arg2),
            collateral : arg0,
            debt       : arg1,
            owner      : 0x2::tx_context::sender(arg2),
        }
    }

    public fun get_collateral_ratio(arg0: &CDP) : u64 {
        15000
    }

    fun init(arg0: BUCKET_MOCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUCKET_MOCK>(arg0, 9, b"BUCK", b"Bucket USD", b"Mock BUCK Token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BUCKET_MOCK>>(v1);
        let v2 = BuckTreasury{
            id  : 0x2::object::new(arg1),
            cap : v0,
        };
        0x2::transfer::share_object<BuckTreasury>(v2);
    }

    public fun mint_mock(arg0: &mut BuckTreasury, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<BUCKET_MOCK> {
        0x2::coin::mint<BUCKET_MOCK>(&mut arg0.cap, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

