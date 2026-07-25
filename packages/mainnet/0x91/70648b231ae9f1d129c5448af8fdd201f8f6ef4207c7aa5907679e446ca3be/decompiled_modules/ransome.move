module 0x9170648b231ae9f1d129c5448af8fdd201f8f6ef4207c7aa5907679e446ca3be::ransome {
    struct Session has store, key {
        id: 0x2::object::UID,
        authorities: vector<address>,
        threshold: u64,
        active: bool,
        paused: bool,
        vault: 0x2::coin::Coin<0x2::sui::SUI>,
        vault_balance: u64,
        wins_claimed: vector<bool>,
        device_count: u64,
        max_withdrawal: u64,
    }

    struct Device has store, key {
        id: 0x2::object::UID,
        session_id: 0x2::object::ID,
        owner: address,
        device_index: u8,
    }

    fun calculate_payout_amount(arg0: u64, arg1: u8) : u64 {
        let v0 = if (arg1 == 0) {
            500
        } else if (arg1 == 1) {
            500
        } else if (arg1 == 2) {
            500
        } else if (arg1 == 3) {
            500
        } else if (arg1 == 4) {
            1000
        } else if (arg1 == 5) {
            1000
        } else {
            2000
        };
        arg0 * v0 / 10000
    }

    public entry fun claim_win(arg0: &mut Session, arg1: address, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.active, 0);
        assert!(!arg0.paused, 7);
        assert!(is_authority(arg0, 0x2::tx_context::sender(arg3)), 3);
        assert!(arg2 < 7, 5);
        let v0 = (arg2 as u64);
        assert!(*0x1::vector::borrow<bool>(&arg0.wins_claimed, v0) == false, 4);
        let v1 = calculate_payout_amount(arg0.vault_balance, arg2);
        assert!(v1 > 0 && v1 <= arg0.vault_balance, 6);
        assert!(v1 <= arg0.max_withdrawal, 8);
        *0x1::vector::borrow_mut<bool>(&mut arg0.wins_claimed, v0) = true;
        arg0.vault_balance = arg0.vault_balance - v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg0.vault, v1, arg3), arg1);
    }

    public entry fun close_session(arg0: &mut Session, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.active, 0);
        assert!(is_authority(arg0, 0x2::tx_context::sender(arg2)), 3);
        arg0.active = false;
        let v0 = 0x2::balance::value<0x2::sui::SUI>(0x2::coin::balance<0x2::sui::SUI>(&arg0.vault));
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg0.vault, v0, arg2), arg1);
        };
        arg0.vault_balance = 0;
    }

    public entry fun initialize_session(arg0: vector<address>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0 && arg1 <= 0x1::vector::length<address>(&arg0), 9);
        let v0 = Session{
            id             : 0x2::object::new(arg2),
            authorities    : arg0,
            threshold      : arg1,
            active         : true,
            paused         : false,
            vault          : 0x2::coin::zero<0x2::sui::SUI>(arg2),
            vault_balance  : 0,
            wins_claimed   : vector[],
            device_count   : 0,
            max_withdrawal : 10000000000,
        };
        let v1 = 0;
        while (v1 < 7) {
            0x1::vector::push_back<bool>(&mut v0.wins_claimed, false);
            v1 = v1 + 1;
        };
        0x2::transfer::share_object<Session>(v0);
    }

    fun is_authority(arg0: &Session, arg1: address) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg0.authorities)) {
            if (*0x1::vector::borrow<address>(&arg0.authorities, v0) == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public entry fun mint_device(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut Session, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.active, 0);
        assert!(!arg1.paused, 7);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 >= 500000000, 1);
        assert!(arg1.device_count < 20, 2);
        let v1 = Device{
            id           : 0x2::object::new(arg3),
            session_id   : 0x2::object::id<Session>(arg1),
            owner        : 0x2::tx_context::sender(arg3),
            device_index : arg2,
        };
        0x2::coin::join<0x2::sui::SUI>(&mut arg1.vault, arg0);
        arg1.vault_balance = arg1.vault_balance + v0;
        arg1.device_count = arg1.device_count + 1;
        0x2::transfer::public_transfer<Device>(v1, 0x2::tx_context::sender(arg3));
    }

    public entry fun pause_session(arg0: &mut Session, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.active, 0);
        assert!(is_authority(arg0, 0x2::tx_context::sender(arg1)), 3);
        arg0.paused = true;
    }

    public entry fun refund_device(arg0: &mut Session, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.active, 0);
        assert!(!arg0.paused, 7);
        assert!(arg0.vault_balance >= 500000000, 6);
        assert!(arg0.device_count > 0, 6);
        arg0.device_count = arg0.device_count - 1;
        arg0.vault_balance = arg0.vault_balance - 500000000;
    }

    public entry fun unpause_session(arg0: &mut Session, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.active, 0);
        assert!(is_authority(arg0, 0x2::tx_context::sender(arg1)), 3);
        arg0.paused = false;
    }

    // decompiled from Move bytecode v7
}

