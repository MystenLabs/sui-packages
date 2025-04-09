module 0x82aeab3472b413da5630d5714da246725e43721930c3109349eeae5fa7fdbf89::AgentO {
    struct BurnEvent has copy, drop, store {
        triggered_by: address,
        current_burn: u64,
        burned_amount: u64,
        fuel_time: u64,
        last_burn_time: u64,
        timestamp: u64,
    }

    struct AGENTO has drop {
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

    fun init(arg0: AGENTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AGENTO>(arg0, 6, b"AgentO", b"AgentO", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AGENTO>>(v1);
        let v3 = 0x2::coin::mint<AGENTO>(&mut v2, 100000000 * 1000000, arg1);
        let v4 = 0x2::coin::value<AGENTO>(&v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<AGENTO>>(0x2::coin::split<AGENTO>(&mut v3, v4 * 20 / 100, arg1), @0x8da9a726eff987a854161291073eb95726ebc3fc83084f2846b3ec3afdebda76);
        0x2::transfer::public_transfer<0x2::coin::Coin<AGENTO>>(0x2::coin::split<AGENTO>(&mut v3, v4 * 30 / 100, arg1), @0x81450ed5bdbe2f9528560d2edb59cef5df40ab3ba335a947862334fadae1e108);
        0x2::transfer::public_transfer<0x2::coin::Coin<AGENTO>>(v3, @0xf4fbeba2b15b177836112e844b7e4a992f80d289bb852ef6e932d9978dddd11);
        let v5 = TokenInfo{
            id              : 0x2::object::new(arg1),
            total_supply    : 100000000,
            target_supply   : 10000000,
            planned_burn    : 90000000,
            burned_amount   : 0,
            fuel_time       : 0,
            last_burn_time  : 0,
            begin_burn_time : 0,
        };
        0x2::transfer::public_share_object<TokenInfo>(v5);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<AGENTO>>(v2);
    }

    public fun owner_auto_burn(arg0: &mut 0x2::coin::TreasuryCap<AGENTO>, arg1: &mut TokenInfo, arg2: &mut 0x2::coin::Coin<AGENTO>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        if (0x2::coin::value<AGENTO>(arg2) == 0) {
            abort 1
        };
        let v0 = 0x2::clock::timestamp_ms(arg3) / 1000;
        if (arg1.last_burn_time == 0) {
            arg1.last_burn_time = v0;
            arg1.begin_burn_time = v0;
        };
        let v1 = arg1.total_supply - arg1.burned_amount;
        if (v1 <= arg1.target_supply) {
            return
        };
        if (v0 - arg1.last_burn_time >= 600) {
            let v2 = (v0 - arg1.begin_burn_time - arg1.fuel_time) / 6;
            let v3 = v2;
            if (v1 - v2 < arg1.target_supply) {
                v3 = v1 - arg1.target_supply;
            };
            if (v3 == 0) {
                return
            };
            let v4 = 100800;
            if (v3 > v4) {
                v3 = v4;
            };
            if (0x2::coin::value<AGENTO>(arg2) < v3 * 1000000) {
                abort 1
            };
            0x2::coin::burn<AGENTO>(arg0, 0x2::coin::split<AGENTO>(arg2, v3 * 1000000, arg4));
            arg1.burned_amount = arg1.burned_amount + v3;
            arg1.fuel_time = arg1.fuel_time + v3 * 6;
            arg1.last_burn_time = v0;
            let v5 = BurnEvent{
                triggered_by   : 0x2::tx_context::sender(arg4),
                current_burn   : v3,
                burned_amount  : arg1.burned_amount,
                fuel_time      : arg1.fuel_time,
                last_burn_time : arg1.last_burn_time,
                timestamp      : v0,
            };
            0x2::event::emit<BurnEvent>(v5);
        };
    }

    // decompiled from Move bytecode v6
}

