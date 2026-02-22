module 0x8c1ae6083a2802691f445bc5005444298c34daf9d08ece020f51e88dafdcea4f::gift_payments {
    struct GIFT_PAYMENTS has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Config has key {
        id: 0x2::object::UID,
        team_treasury: address,
        general_treasury: address,
        total_gifts_sent: u64,
        total_volume: u64,
    }

    struct GiftSent has copy, drop {
        sender: address,
        creator: address,
        gift_id: 0x1::string::String,
        stream_id: 0x1::string::String,
        total_amount: u64,
        creator_amount: u64,
        team_amount: u64,
        affiliate_amount: u64,
        affiliate_routed: bool,
        timestamp: u64,
    }

    struct TreasuryUpdated has copy, drop {
        team_treasury: address,
        general_treasury: address,
        timestamp: u64,
    }

    public fun get_total_gifts_sent(arg0: &Config) : u64 {
        arg0.total_gifts_sent
    }

    public fun get_total_volume(arg0: &Config) : u64 {
        arg0.total_volume
    }

    public fun get_treasury_addresses(arg0: &Config) : (address, address) {
        (arg0.team_treasury, arg0.general_treasury)
    }

    fun init(arg0: GIFT_PAYMENTS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        let v1 = Config{
            id               : 0x2::object::new(arg1),
            team_treasury    : @0x8e9d3694f494a0da57fd189697e03bd33e7b9ee615fb15735ee58eacba753091,
            general_treasury : @0x471eb35b113b5e76797d266870585b8d98897bc3260c06723d8fd984d0f007cd,
            total_gifts_sent : 0,
            total_volume     : 0,
        };
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<Config>(v1);
    }

    public entry fun send_gift<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0xa55da33f92dc59fcf429bd5fbc506dfe454a3ca41073a2aeb5c70afb3aa9d1f6::affiliate_system::Registry<T0>, arg5: &mut Config, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 > 0, 1);
        let v1 = v0 * 8000 / 10000;
        let v2 = v0 * 1600 / 10000;
        let v3 = v0 - v1 - v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0, v1, arg7), arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0, v2, arg7), arg5.team_treasury);
        let v4 = if (0xa55da33f92dc59fcf429bd5fbc506dfe454a3ca41073a2aeb5c70afb3aa9d1f6::affiliate_system::is_registered<T0>(arg4, arg1)) {
            0xa55da33f92dc59fcf429bd5fbc506dfe454a3ca41073a2aeb5c70afb3aa9d1f6::affiliate_system::deposit_funds<T0>(arg4, arg0, arg7);
            0xa55da33f92dc59fcf429bd5fbc506dfe454a3ca41073a2aeb5c70afb3aa9d1f6::affiliate_system::payout_sale<T0>(arg4, v3, arg1, arg7);
            true
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg5.general_treasury);
            false
        };
        arg5.total_gifts_sent = arg5.total_gifts_sent + 1;
        arg5.total_volume = arg5.total_volume + v0;
        let v5 = GiftSent{
            sender           : 0x2::tx_context::sender(arg7),
            creator          : arg1,
            gift_id          : arg2,
            stream_id        : arg3,
            total_amount     : v0,
            creator_amount   : v1,
            team_amount      : v2,
            affiliate_amount : v3,
            affiliate_routed : v4,
            timestamp        : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::event::emit<GiftSent>(v5);
    }

    public entry fun update_treasury(arg0: &AdminCap, arg1: &mut Config, arg2: address, arg3: address, arg4: &0x2::clock::Clock) {
        arg1.team_treasury = arg2;
        arg1.general_treasury = arg3;
        let v0 = TreasuryUpdated{
            team_treasury    : arg2,
            general_treasury : arg3,
            timestamp        : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<TreasuryUpdated>(v0);
    }

    // decompiled from Move bytecode v6
}

