module 0x734b19fa1696dec30f8cae38f1cdbf0ab5a12720735f7c7b0d4935cab31732cc::chest {
    struct Chest has store, key {
        id: 0x2::object::UID,
        vessel_id: 0x2::object::ID,
        owner: address,
        blob_id: vector<u8>,
        seal_id: vector<u8>,
        size_tier: u8,
        size_bytes: u64,
        access_fee: u64,
        state: u8,
        created_at: u64,
        expires_at: u64,
        access_count: u64,
        author: address,
    }

    struct ChestOpened has copy, drop {
        chest_id: address,
        vessel_id: address,
        size_tier: u8,
        size_bytes: u64,
        access_fee: u64,
        expires_at: u64,
        opened_at: u64,
    }

    struct ChestAccessed has copy, drop {
        chest_id: address,
        reader: address,
        blob_id: vector<u8>,
        seal_id: vector<u8>,
        fee_paid: u64,
        access_count: u64,
        accessed_at: u64,
    }

    struct ChestBurned has copy, drop {
        chest_id: address,
        owner: address,
        burned_at: u64,
    }

    struct ChestExtended has copy, drop {
        chest_id: address,
        new_expiry: u64,
        extended_at: u64,
    }

    public fun access(arg0: &mut Chest, arg1: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg2: &mut 0x734b19fa1696dec30f8cae38f1cdbf0ab5a12720735f7c7b0d4935cab31732cc::abyss::Abyss, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(is_alive(arg0, arg3), 1);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg1);
        if (arg0.access_fee == 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(arg1, v0);
        } else {
            assert!(v1 >= arg0.access_fee, 7);
            0x734b19fa1696dec30f8cae38f1cdbf0ab5a12720735f7c7b0d4935cab31732cc::abyss::receive_chest_access(arg2, 0x2::coin::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg1, v1 * 300 / 10000, arg4), arg3, arg4);
            0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(arg1, arg0.author);
        };
        arg0.access_count = arg0.access_count + 1;
        let v2 = 0x2::object::id<Chest>(arg0);
        let v3 = ChestAccessed{
            chest_id     : 0x2::object::id_to_address(&v2),
            reader       : v0,
            blob_id      : arg0.blob_id,
            seal_id      : arg0.seal_id,
            fee_paid     : v1,
            access_count : arg0.access_count,
            accessed_at  : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<ChestAccessed>(v3);
    }

    public fun access_count(arg0: &Chest) : u64 {
        arg0.access_count
    }

    public fun access_fee(arg0: &Chest) : u64 {
        arg0.access_fee
    }

    public fun blob_id(arg0: &Chest) : vector<u8> {
        arg0.blob_id
    }

    public fun burn(arg0: &mut Chest, arg1: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg2: &mut 0x734b19fa1696dec30f8cae38f1cdbf0ab5a12720735f7c7b0d4935cab31732cc::abyss::Abyss, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.state == 0, 1);
        assert!(0x2::tx_context::sender(arg4) == arg0.owner, 2);
        0x734b19fa1696dec30f8cae38f1cdbf0ab5a12720735f7c7b0d4935cab31732cc::abyss::receive_chest_burn(arg2, arg1, arg3, arg4);
        arg0.blob_id = b"";
        arg0.seal_id = b"";
        arg0.state = 1;
        let v0 = 0x2::object::id<Chest>(arg0);
        let v1 = ChestBurned{
            chest_id  : 0x2::object::id_to_address(&v0),
            owner     : arg0.owner,
            burned_at : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<ChestBurned>(v1);
    }

    public fun extend(arg0: &mut Chest, arg1: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg2: &mut 0x734b19fa1696dec30f8cae38f1cdbf0ab5a12720735f7c7b0d4935cab31732cc::abyss::Abyss, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(is_alive(arg0, arg4), 6);
        assert!(0x2::tx_context::sender(arg5) == arg0.owner, 2);
        0x734b19fa1696dec30f8cae38f1cdbf0ab5a12720735f7c7b0d4935cab31732cc::abyss::receive_chest_extend(arg2, arg1, arg4, arg5);
        arg0.expires_at = arg0.expires_at + arg3 * 604800000;
        let v0 = 0x2::object::id<Chest>(arg0);
        let v1 = ChestExtended{
            chest_id    : 0x2::object::id_to_address(&v0),
            new_expiry  : arg0.expires_at,
            extended_at : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<ChestExtended>(v1);
    }

    public fun fee_burn() : u64 {
        20000
    }

    public fun fee_extend() : u64 {
        20000
    }

    public fun fee_open_large() : u64 {
        250000
    }

    public fun fee_open_nano() : u64 {
        50000
    }

    public fun fee_open_standard() : u64 {
        100000
    }

    fun is_alive(arg0: &Chest, arg1: &0x2::clock::Clock) : bool {
        arg0.state == 0 && 0x2::clock::timestamp_ms(arg1) < arg0.expires_at
    }

    public fun is_live(arg0: &Chest, arg1: &0x2::clock::Clock) : bool {
        is_alive(arg0, arg1)
    }

    fun max_bytes(arg0: u8) : u64 {
        if (arg0 == 0) {
            102400
        } else if (arg0 == 1) {
            1048576
        } else {
            assert!(arg0 == 2, 4);
            10485760
        }
    }

    public fun min_access_fee() : u64 {
        10000
    }

    public fun open(arg0: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg1: &mut 0x734b19fa1696dec30f8cae38f1cdbf0ab5a12720735f7c7b0d4935cab31732cc::abyss::Abyss, arg2: 0x2::object::ID, arg3: vector<u8>, arg4: vector<u8>, arg5: u8, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg5 <= 2, 4);
        assert!(arg6 <= max_bytes(arg5), 5);
        assert!(arg7 == 0 || arg7 >= 10000, 3);
        0x734b19fa1696dec30f8cae38f1cdbf0ab5a12720735f7c7b0d4935cab31732cc::abyss::receive_chest_open(arg1, arg0, arg5, arg9, arg10);
        let v0 = 0x2::tx_context::sender(arg10);
        let v1 = 0x2::clock::timestamp_ms(arg9);
        let v2 = if (arg8 == 0) {
            5
        } else {
            arg8
        };
        let v3 = Chest{
            id           : 0x2::object::new(arg10),
            vessel_id    : arg2,
            owner        : v0,
            blob_id      : arg3,
            seal_id      : arg4,
            size_tier    : arg5,
            size_bytes   : arg6,
            access_fee   : arg7,
            state        : 0,
            created_at   : v1,
            expires_at   : v1 + v2 * 604800000,
            access_count : 0,
            author       : v0,
        };
        let v4 = 0x2::object::id<Chest>(&v3);
        let v5 = ChestOpened{
            chest_id   : 0x2::object::id_to_address(&v4),
            vessel_id  : 0x2::object::id_to_address(&arg2),
            size_tier  : arg5,
            size_bytes : arg6,
            access_fee : arg7,
            expires_at : v3.expires_at,
            opened_at  : v1,
        };
        0x2::event::emit<ChestOpened>(v5);
        0x2::transfer::share_object<Chest>(v3);
    }

    fun open_fee(arg0: u8) : u64 {
        if (arg0 == 0) {
            50000
        } else if (arg0 == 1) {
            100000
        } else {
            assert!(arg0 == 2, 4);
            250000
        }
    }

    public fun seal_id(arg0: &Chest) : vector<u8> {
        arg0.seal_id
    }

    public fun size_bytes(arg0: &Chest) : u64 {
        arg0.size_bytes
    }

    public fun size_tier(arg0: &Chest) : u8 {
        arg0.size_tier
    }

    // decompiled from Move bytecode v7
}

