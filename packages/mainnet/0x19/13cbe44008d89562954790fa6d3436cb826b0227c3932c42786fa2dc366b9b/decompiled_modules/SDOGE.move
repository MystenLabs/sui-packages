module 0x1913cbe44008d89562954790fa6d3436cb826b0227c3932c42786fa2dc366b9b::SDOGE {
    struct SDOGE has drop {
        dummy_field: bool,
    }

    struct IPXStorage has key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<SDOGE>,
        minters: 0x2::vec_set::VecSet<0x2::object::ID>,
    }

    struct IPXAdminCap has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: SDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDOGE>(arg0, 9, b"SDOGE", b"SuiDoge", b"SuiDoge is the First ecosystem-focused and community-driven #memecoin #NFT with utility on #Sui $Sui", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = 0x2::coin::treasury_into_supply<SDOGE>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<SDOGE>>(0x2::coin::from_balance<SDOGE>(0x2::balance::increase_supply<SDOGE>(&mut v2, 100000000000000000), arg1), 0x2::tx_context::sender(arg1));
        let v3 = IPXAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<IPXAdminCap>(v3, 0x2::tx_context::sender(arg1));
        let v4 = IPXStorage{
            id      : 0x2::object::new(arg1),
            supply  : v2,
            minters : 0x2::vec_set::empty<0x2::object::ID>(),
        };
        0x2::transfer::share_object<IPXStorage>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SDOGE>>(v1);
    }

    public fun total_supply(arg0: &IPXStorage) : u64 {
        0x2::balance::supply_value<SDOGE>(&arg0.supply)
    }

    // decompiled from Move bytecode v6
}

