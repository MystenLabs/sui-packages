module 0x4775f19a14eacfae09ad479a1f6d4d6ebeb8ad9cf79c906c67804f063e2e2859::xyz {
    struct XYZ has drop {
        dummy_field: bool,
    }

    struct MintEvent has copy, drop {
        minter: address,
        amount: u64,
        timestamp: u64,
    }

    struct MintRecord has store {
        last_mint_day: u64,
        amount_minted_today: u64,
    }

    struct PublicTreasury has store, key {
        id: 0x2::object::UID,
        cap: 0x2::coin::TreasuryCap<XYZ>,
        records: 0x2::table::Table<address, MintRecord>,
    }

    public fun get_mint_info(arg0: &PublicTreasury, arg1: address, arg2: &0x2::clock::Clock) : (u64, u64) {
        if (!0x2::table::contains<address, MintRecord>(&arg0.records, arg1)) {
            return (1000000000000, 0)
        };
        let v0 = 0x2::table::borrow<address, MintRecord>(&arg0.records, arg1);
        if (v0.last_mint_day < 0x2::clock::timestamp_ms(arg2) / 1000 / 86400) {
            return (1000000000000, 0)
        };
        let v1 = v0.amount_minted_today;
        let v2 = if (v1 >= 1000000000000) {
            0
        } else {
            1000000000000 - v1
        };
        (v2, v1)
    }

    fun init(arg0: XYZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XYZ>(arg0, 9, b"XYZ", b"XYZ", b"XYZ is native test coin only for testing purposes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://salmon-accused-puma-149.mypinata.cloud/ipfs/bafkreihtz6vozbrc3fl5bezr2tlx6fcjn23s3cekvvbf3jhlhbybz7axpy?pinataGatewayToken=Nc4R8TH9sXtjJQUiqvn_ZXvRnNYOlp6eH8lT7JTr0zEUEZV2BjEMU-81HiF2dy5x")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<XYZ>>(0x2::coin::mint<XYZ>(&mut v2, 100000000000000000, arg1), 0x2::tx_context::sender(arg1));
        let v3 = PublicTreasury{
            id      : 0x2::object::new(arg1),
            cap     : v2,
            records : 0x2::table::new<address, MintRecord>(arg1),
        };
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XYZ>>(v1);
        0x2::transfer::public_share_object<PublicTreasury>(v3);
    }

    fun mint_internal(arg0: &mut PublicTreasury, arg1: u64, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::clock::timestamp_ms(arg3) / 1000;
        let v2 = v1 / 86400;
        if (!0x2::table::contains<address, MintRecord>(&arg0.records, v0)) {
            let v3 = MintRecord{
                last_mint_day       : v2,
                amount_minted_today : 0,
            };
            0x2::table::add<address, MintRecord>(&mut arg0.records, v0, v3);
        };
        let v4 = 0x2::table::borrow_mut<address, MintRecord>(&mut arg0.records, v0);
        if (v4.last_mint_day < v2) {
            v4.last_mint_day = v2;
            v4.amount_minted_today = 0;
        };
        assert!(v4.amount_minted_today + arg1 <= 1000000000000, 1);
        v4.amount_minted_today = v4.amount_minted_today + arg1;
        0x2::transfer::public_transfer<0x2::coin::Coin<XYZ>>(0x2::coin::mint<XYZ>(&mut arg0.cap, arg1, arg4), arg2);
        let v5 = MintEvent{
            minter    : v0,
            amount    : arg1,
            timestamp : v1,
        };
        0x2::event::emit<MintEvent>(v5);
    }

    public entry fun public_mint(arg0: &mut PublicTreasury, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        mint_internal(arg0, arg1, v0, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

