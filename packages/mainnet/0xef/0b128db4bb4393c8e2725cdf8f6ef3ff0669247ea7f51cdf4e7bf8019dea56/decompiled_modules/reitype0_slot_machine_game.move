module 0xef0b128db4bb4393c8e2725cdf8f6ef3ff0669247ea7f51cdf4e7bf8019dea56::reitype0_slot_machine_game {
    struct JACKPOT_POOL<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
    }

    struct SpinResult has copy, drop, store {
        spin1: u8,
        spin2: u8,
        spin3: u8,
    }

    struct SlotMachineResultEvent has copy, drop {
        is_win: bool,
        player_spins: SpinResult,
        winning_combination: SpinResult,
        result: 0x1::string::String,
    }

    entry fun create_pool<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = JACKPOT_POOL<T0>{
            id      : 0x2::object::new(arg0),
            balance : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::share_object<JACKPOT_POOL<T0>>(v0);
    }

    fun get_spin_result(arg0: &0x2::clock::Clock) : SpinResult {
        let v0 = 0x2::clock::timestamp_ms(arg0);
        SpinResult{
            spin1 : ((v0 % ((5 as u64) + 1)) as u8),
            spin2 : ((v0 / 100 % ((5 as u64) + 1)) as u8),
            spin3 : ((v0 / 10000 % ((5 as u64) + 1)) as u8),
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    entry fun play<T0>(arg0: &0x2::clock::Clock, arg1: &mut JACKPOT_POOL<T0>, arg2: &mut 0x2::coin::TreasuryCap<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = get_spin_result(arg0);
        let v1 = SpinResult{
            spin1 : 2,
            spin2 : 2,
            spin3 : 2,
        };
        let (v2, v3) = if (v0.spin1 == v1.spin1 && v0.spin2 == v1.spin2 && v0.spin3 == v1.spin3) {
            (x"436f6e67726174756c6174696f6e732c20796f752068697420746865206a61636b706f742120436f6c6c65637420796f757220636f696e73f09f9884", true)
        } else {
            (x"54727920616761696e2c20626574746572206c75636b206e6578742074696d6521f09f9294", false)
        };
        let v4 = SlotMachineResultEvent{
            is_win              : v3,
            player_spins        : v0,
            winning_combination : v1,
            result              : 0x1::string::utf8(v2),
        };
        0x2::event::emit<SlotMachineResultEvent>(v4);
        if (v3) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg1.balance), arg3), 0x2::tx_context::sender(arg3));
        } else {
            0x2::balance::join<T0>(&mut arg1.balance, 0x2::coin::into_balance<T0>(0x2::coin::mint<T0>(arg2, 1, arg3)));
        };
    }

    // decompiled from Move bytecode v6
}

