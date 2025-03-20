module 0x93cf82e5a105a087680a12913fe81c3e325335ee9f11a622a05fee633acf3044::hipp {
    struct BurnEvent has copy, drop, store {
        triggered_by: address,
        current_burn: u64,
        burned_amount: u64,
        fuel_time: u64,
        last_burn_time: u64,
        timestamp: u64,
    }

    struct HIPP has drop {
        dummy_field: bool,
    }

    struct TokenInfo has store, key {
        id: 0x2::object::UID,
        total_supply: u64,
        target_supply: u64,
        planned_burn: u64,
        burned_amount: u64,
        fuel_time: u64,
        last_burn_time: u64,
        begin_burn_time: u64,
    }

    struct MintCapHolder has store, key {
        id: 0x2::object::UID,
        cap: 0x2::coin::TreasuryCap<HIPP>,
    }

    fun init(arg0: HIPP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIPP>(arg0, 6, b"Hipponaut", b"HIPP", b"Hipponaut - Meme coin with deflationary rocket journey", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://raw.githubusercontent.com/Hipponaut2025/hipponaut/refs/heads/main/images/logo.jpg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HIPP>>(v1);
        let v3 = 0x2::coin::mint<HIPP>(&mut v2, 94584000 * 1000000, arg1);
        let v4 = 0x2::coin::value<HIPP>(&v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<HIPP>>(0x2::coin::split<HIPP>(&mut v3, v4 * 20 / 100, arg1), @0x35f719cbf9d592c61cabad014fa7930c588046a7f63b2dd91768f1b10bf73224);
        0x2::transfer::public_transfer<0x2::coin::Coin<HIPP>>(0x2::coin::split<HIPP>(&mut v3, v4 * 30 / 100, arg1), @0x63d3a391aa626265219b61f188297238748a275b55e1d4c94db99f29a3d84664);
        0x2::transfer::public_transfer<0x2::coin::Coin<HIPP>>(v3, @0xa3ba2ca1871243f96b474e0c517d90590b8b2501e972ef4e7db03065def787f);
        let v5 = TokenInfo{
            id              : 0x2::object::new(arg1),
            total_supply    : 94584000,
            target_supply   : 21000000,
            planned_burn    : 73584000,
            burned_amount   : 0,
            fuel_time       : 0,
            last_burn_time  : 0,
            begin_burn_time : 0,
        };
        0x2::transfer::public_share_object<TokenInfo>(v5);
        let v6 = MintCapHolder{
            id  : 0x2::object::new(arg1),
            cap : v2,
        };
        0x2::transfer::public_share_object<MintCapHolder>(v6);
    }

    public fun owner_auto_burn(arg0: &mut TokenInfo, arg1: &mut 0x2::coin::Coin<HIPP>, arg2: &mut MintCapHolder, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        if (0x2::coin::value<HIPP>(arg1) == 0) {
            abort 1
        };
        let v0 = 0x2::clock::timestamp_ms(arg3) / 1000;
        if (arg0.last_burn_time == 0) {
            arg0.last_burn_time = v0;
            arg0.begin_burn_time = v0;
        };
        let v1 = arg0.total_supply - arg0.burned_amount;
        if (v1 <= arg0.target_supply) {
            return
        };
        if (v0 - arg0.last_burn_time >= 86400) {
            let v2 = (v0 - arg0.begin_burn_time - arg0.fuel_time) / 6;
            let v3 = v2;
            if (v1 - v2 < arg0.target_supply) {
                v3 = v1 - arg0.target_supply;
            };
            if (v3 == 0) {
                return
            };
            let v4 = 100800;
            if (v3 > v4) {
                v3 = v4;
            };
            if (0x2::coin::value<HIPP>(arg1) < v3 * 1000000) {
                abort 1
            };
            0x2::coin::burn<HIPP>(&mut arg2.cap, 0x2::coin::split<HIPP>(arg1, v3 * 1000000, arg4));
            arg0.burned_amount = arg0.burned_amount + v3;
            arg0.fuel_time = arg0.fuel_time + v3 * 6;
            arg0.last_burn_time = v0;
            let v5 = BurnEvent{
                triggered_by   : 0x2::tx_context::sender(arg4),
                current_burn   : v3,
                burned_amount  : arg0.burned_amount,
                fuel_time      : arg0.fuel_time,
                last_burn_time : arg0.last_burn_time,
                timestamp      : v0,
            };
            0x2::event::emit<BurnEvent>(v5);
        };
    }

    // decompiled from Move bytecode v6
}

