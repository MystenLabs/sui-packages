module 0xdfe2c634a24f0850279dbb321a68d7665331f264c8c596e4fb07773ff9d3b64d::heist {
    struct Session has store, key {
        id: 0x2::object::UID,
        active: bool,
        paused: bool,
        wins_claimed: vector<bool>,
        vault: 0x2::balance::Balance<0x2::sui::SUI>,
        treasury: address,
        authority: address,
        treasury_fee_bps: u64,
        draw_count: u8,
        last_number: u8,
        drawn_numbers: vector<u8>,
        bankrupt_count: u8,
    }

    struct Device has store, key {
        id: 0x2::object::UID,
        session_id: 0x2::object::ID,
        device_index: u8,
    }

    struct SessionCreated has copy, drop {
        session_id: 0x2::object::ID,
        authority: address,
        treasury: address,
        treasury_fee_bps: u64,
    }

    struct DeviceMinted has copy, drop {
        session_id: 0x2::object::ID,
        device_index: u8,
        owner: address,
        amount_paid: u64,
        treasury_fee: u64,
        vault_added: u64,
    }

    struct WinClaimed has copy, drop {
        session_id: 0x2::object::ID,
        win_type: u8,
        num_winners: u64,
        total_payout: u64,
        bps: u64,
    }

    struct NumberDrawn has copy, drop {
        session_id: 0x2::object::ID,
        number: u8,
        draw_count: u8,
        remaining: u8,
    }

    public fun claim_win_split(arg0: &mut Session, arg1: vector<address>, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.active, 1);
        assert!(!arg0.paused, 2);
        assert!(arg2 < 7, 4);
        let v0 = 0x1::vector::length<address>(&arg1);
        assert!(v0 > 0, 5);
        assert!(v0 <= 100, 10);
        let v1 = 0x1::vector::borrow_mut<bool>(&mut arg0.wins_claimed, (arg2 as u64));
        assert!(!*v1, 3);
        *v1 = true;
        let v2 = get_win_bps(arg2);
        let v3 = 0x2::balance::value<0x2::sui::SUI>(&arg0.vault) * v2 / 10000;
        assert!(v3 > 0, 6);
        let v4 = v3 / v0;
        let v5 = 0;
        while (v5 < v0) {
            let v6 = if (v5 == v0 - 1) {
                v4 + v3 - v4 * v0
            } else {
                v4
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.vault, v6, arg3), *0x1::vector::borrow<address>(&arg1, v5));
            v5 = v5 + 1;
        };
        let v7 = WinClaimed{
            session_id   : 0x2::object::id<Session>(arg0),
            win_type     : arg2,
            num_winners  : v0,
            total_payout : v3,
            bps          : v2,
        };
        0x2::event::emit<WinClaimed>(v7);
    }

    public fun draw_number(arg0: &mut Session, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.authority, 9);
        assert!(arg0.active, 1);
        assert!(!arg0.paused, 2);
        let v0 = 0x1::vector::length<u8>(&arg0.drawn_numbers);
        assert!(v0 < 90, 11);
        let v1 = 90 - v0;
        let v2 = b"";
        let v3 = 1;
        while (v3 <= 90) {
            let v4 = false;
            let v5 = 0;
            while (v5 < v0) {
                if (*0x1::vector::borrow<u8>(&arg0.drawn_numbers, v5) == v3) {
                    v4 = true;
                    break
                };
                v5 = v5 + 1;
            };
            if (!v4) {
                0x1::vector::push_back<u8>(&mut v2, v3);
            };
            v3 = v3 + 1;
        };
        let v6 = *0x1::vector::borrow<u8>(&v2, (*0x1::vector::borrow<u8>(0x2::tx_context::digest(arg1), 0) as u64) % v1);
        arg0.last_number = v6;
        arg0.draw_count = arg0.draw_count + 1;
        0x1::vector::push_back<u8>(&mut arg0.drawn_numbers, v6);
        let v7 = NumberDrawn{
            session_id : 0x2::object::id<Session>(arg0),
            number     : v6,
            draw_count : arg0.draw_count,
            remaining  : ((v1 - 1) as u8),
        };
        0x2::event::emit<NumberDrawn>(v7);
    }

    public fun end_session(arg0: &mut Session, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.authority, 9);
        arg0.active = false;
    }

    fun get_win_bps(arg0: u8) : u64 {
        if (arg0 == 0) {
            500
        } else if (arg0 == 1) {
            500
        } else if (arg0 == 2) {
            500
        } else if (arg0 == 3) {
            500
        } else if (arg0 == 4) {
            1950
        } else if (arg0 == 5) {
            1950
        } else {
            assert!(arg0 == 6, 4);
            4000
        }
    }

    public fun initialize_session(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = vector[];
        let v2 = 0;
        while (v2 < 7) {
            0x1::vector::push_back<bool>(&mut v1, false);
            v2 = v2 + 1;
        };
        let v3 = Session{
            id               : 0x2::object::new(arg1),
            active           : true,
            paused           : false,
            wins_claimed     : v1,
            vault            : 0x2::balance::zero<0x2::sui::SUI>(),
            treasury         : arg0,
            authority        : v0,
            treasury_fee_bps : 100,
            draw_count       : 0,
            last_number      : 0,
            drawn_numbers    : b"",
            bankrupt_count   : 0,
        };
        0x2::transfer::share_object<Session>(v3);
        let v4 = SessionCreated{
            session_id       : 0x2::object::id<Session>(&v3),
            authority        : v0,
            treasury         : arg0,
            treasury_fee_bps : 100,
        };
        0x2::event::emit<SessionCreated>(v4);
    }

    public fun mint_device(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut Session, arg2: u64, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) : Device {
        assert!(arg1.active, 1);
        assert!(!arg1.paused, 2);
        assert!(arg3 < 20, 8);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) >= arg2, 7);
        let v0 = arg2 * arg1.treasury_fee_bps / 10000;
        let v1 = arg2 - v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg0, v0, arg4), arg1.treasury);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.vault, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg0, v1, arg4)));
        let v2 = 0x2::tx_context::sender(arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, v2);
        let v3 = DeviceMinted{
            session_id   : 0x2::object::id<Session>(arg1),
            device_index : arg3,
            owner        : v2,
            amount_paid  : arg2,
            treasury_fee : v0,
            vault_added  : v1,
        };
        0x2::event::emit<DeviceMinted>(v3);
        Device{
            id           : 0x2::object::new(arg4),
            session_id   : 0x2::object::id<Session>(arg1),
            device_index : arg3,
        }
    }

    public fun pause_session(arg0: &mut Session, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.authority, 9);
        arg0.paused = true;
    }

    public fun resume_session(arg0: &mut Session, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.authority, 9);
        arg0.paused = false;
    }

    // decompiled from Move bytecode v7
}

