module 0x39019f183d8d19df19bd7c3e14fed735c7a1b11e2aa02669eba1089602394c3e::gts {
    struct GTS has drop {
        dummy_field: bool,
    }

    struct Treasury has key {
        id: 0x2::object::UID,
        cap: 0x2::coin::TreasuryCap<GTS>,
        vault: 0x2::balance::Balance<0x2::sui::SUI>,
        genesis_ms: u64,
        minted: u64,
    }

    struct MinterCap has store, key {
        id: 0x2::object::UID,
    }

    struct Redeemed has copy, drop {
        player: address,
        gts_burned: u64,
        sui_out: u64,
    }

    public fun mint(arg0: &mut Treasury, arg1: &MinterCap, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<GTS> {
        let v0 = allowance(arg0, 0x2::clock::timestamp_ms(arg3));
        let v1 = if (v0 > arg0.minted) {
            v0 - arg0.minted
        } else {
            0
        };
        let v2 = if (arg2 > v1) {
            v1
        } else {
            arg2
        };
        arg0.minted = arg0.minted + v2;
        if (v2 == 0) {
            0x2::coin::zero<GTS>(arg4)
        } else {
            0x2::coin::mint<GTS>(&mut arg0.cap, v2, arg4)
        }
    }

    public fun total_supply(arg0: &Treasury) : u64 {
        0x2::coin::total_supply<GTS>(&arg0.cap)
    }

    public fun update_description(arg0: &Treasury, arg1: &mut 0x2::coin::CoinMetadata<GTS>, arg2: 0x1::string::String) {
        0x2::coin::update_description<GTS>(&arg0.cap, arg1, arg2);
    }

    public fun update_icon_url(arg0: &Treasury, arg1: &mut 0x2::coin::CoinMetadata<GTS>, arg2: 0x1::ascii::String) {
        0x2::coin::update_icon_url<GTS>(&arg0.cap, arg1, arg2);
    }

    public fun allowance(arg0: &Treasury, arg1: u64) : u64 {
        let v0 = arg0.genesis_ms;
        if (v0 == 0) {
            return 0
        };
        let v1 = if (arg1 < 1893456000000) {
            arg1
        } else {
            1893456000000
        };
        if (v1 <= v0) {
            return 0
        };
        let v2 = 0;
        let v3 = 0;
        while (v0 < v1 && v3 < 64) {
            let v4 = if (v0 + 15778800000 < v1) {
                v0 + 15778800000
            } else {
                v1
            };
            v2 = v2 + ((1100000000 >> v3) as u128) * ((v4 - v0) as u128) / (60000 as u128);
            v0 = v4;
            v3 = v3 + 1;
        };
        if (v2 > (1000000000000000 as u128)) {
            1000000000000000
        } else {
            (v2 as u64)
        }
    }

    public fun emission_end_ms() : u64 {
        1893456000000
    }

    public fun floor_price_scaled(arg0: &Treasury) : u64 {
        let v0 = 0x2::coin::total_supply<GTS>(&arg0.cap);
        if (v0 == 0) {
            0
        } else {
            (((0x2::balance::value<0x2::sui::SUI>(&arg0.vault) as u128) * 1000000000 / (v0 as u128)) as u64)
        }
    }

    public fun genesis_ms(arg0: &Treasury) : u64 {
        arg0.genesis_ms
    }

    public fun halving_ms() : u64 {
        15778800000
    }

    fun init(arg0: GTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GTS>(arg0, 9, b"GTS", b"GTStar", b"Fair-launch mining token on Sui, backed by a SUI reserve.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gtstar-sui.netlify.app/icon.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GTS>>(v1, 0x2::tx_context::sender(arg1));
        let v2 = Treasury{
            id         : 0x2::object::new(arg1),
            cap        : v0,
            vault      : 0x2::balance::zero<0x2::sui::SUI>(),
            genesis_ms : 0,
            minted     : 0,
        };
        0x2::transfer::share_object<Treasury>(v2);
        let v3 = MinterCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<MinterCap>(v3, 0x2::tx_context::sender(arg1));
    }

    public fun max_supply() : u64 {
        1000000000000000
    }

    public fun minted(arg0: &Treasury) : u64 {
        arg0.minted
    }

    public fun redeem(arg0: &mut Treasury, arg1: 0x2::coin::Coin<GTS>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::coin::value<GTS>(&arg1);
        assert!(v0 > 0, 1);
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&arg0.vault);
        assert!(v1 > 0, 2);
        let v2 = (((v1 as u128) * (v0 as u128) / (0x2::coin::total_supply<GTS>(&arg0.cap) as u128)) as u64);
        0x2::coin::burn<GTS>(&mut arg0.cap, arg1);
        let v3 = Redeemed{
            player     : 0x2::tx_context::sender(arg2),
            gts_burned : v0,
            sui_out    : v2,
        };
        0x2::event::emit<Redeemed>(v3);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.vault, v2), arg2)
    }

    public fun start(arg0: &mut Treasury, arg1: &MinterCap, arg2: &0x2::clock::Clock) {
        assert!(arg0.genesis_ms == 0, 3);
        arg0.genesis_ms = 0x2::clock::timestamp_ms(arg2);
    }

    public fun vault_add(arg0: &mut Treasury, arg1: 0x2::balance::Balance<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.vault, arg1);
    }

    public fun vault_value(arg0: &Treasury) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.vault)
    }

    // decompiled from Move bytecode v7
}

