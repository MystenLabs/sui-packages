module 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::account {
    struct Nonce has drop, store {
        expiry_ms: u64,
        filled: u64,
        digest: vector<u8>,
        instrument: u256,
        cancelled: bool,
        key_epoch: u64,
        children_filled: u64,
        last_fill_ms: u64,
        fired_at_ms: u64,
        fired_proof_ms: u64,
        fired_cover: u64,
        fired_used: u64,
    }

    struct Fire has copy, drop, store {
        at_ms: u64,
        proof_ms: u64,
        cover: u64,
    }

    struct Busy has copy, drop, store {
        dummy_field: bool,
    }

    struct Account has store {
        trading_pubkey: vector<u8>,
        key_epoch: u64,
        nonces: 0x2::table::Table<u64, Nonce>,
        balances: 0x2::table::Table<0x1::type_name::TypeName, u64>,
        seq: u64,
        margin_enabled: bool,
        debt: u64,
        max_debt: 0x1::option::Option<u64>,
        open_positions: u64,
        penalties: u64,
        extras: 0x2::bag::Bag,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : Account {
        Account{
            trading_pubkey : b"",
            key_epoch      : 0,
            nonces         : 0x2::table::new<u64, Nonce>(arg0),
            balances       : 0x2::table::new<0x1::type_name::TypeName, u64>(arg0),
            seq            : 0,
            margin_enabled : false,
            debt           : 0,
            max_debt       : 0x1::option::none<u64>(),
            open_positions : 0,
            penalties      : 0,
            extras         : 0x2::bag::new(arg0),
        }
    }

    public(friend) fun add_child_fill(arg0: &mut Account, arg1: u64, arg2: u64) {
        let v0 = 0x2::table::borrow_mut<u64, Nonce>(&mut arg0.nonces, arg1);
        v0.children_filled = v0.children_filled + arg2;
    }

    public(friend) fun add_penalty(arg0: &mut Account, arg1: u64) {
        arg0.penalties = arg0.penalties + arg1;
    }

    public fun balance(arg0: &Account, arg1: &0x1::type_name::TypeName) : u64 {
        if (0x2::table::contains<0x1::type_name::TypeName, u64>(&arg0.balances, *arg1)) {
            *0x2::table::borrow<0x1::type_name::TypeName, u64>(&arg0.balances, *arg1)
        } else {
            0
        }
    }

    public(friend) fun bump(arg0: &mut Account) {
        arg0.seq = arg0.seq + 1;
    }

    public(friend) fun cancel_nonce(arg0: &mut Account, arg1: u64) {
        if (0x2::table::contains<u64, Nonce>(&arg0.nonces, arg1)) {
            0x2::table::borrow_mut<u64, Nonce>(&mut arg0.nonces, arg1).cancelled = true;
        } else {
            let v0 = Nonce{
                expiry_ms       : 18446744073709551615,
                filled          : 0,
                digest          : b"",
                instrument      : 0,
                cancelled       : true,
                key_epoch       : arg0.key_epoch,
                children_filled : 0,
                last_fill_ms    : 0,
                fired_at_ms     : 0,
                fired_proof_ms  : 0,
                fired_cover     : 0,
                fired_used      : 0,
            };
            0x2::table::add<u64, Nonce>(&mut arg0.nonces, arg1, v0);
        };
    }

    public fun children_filled(arg0: &Account, arg1: u64) : u64 {
        if (0x2::table::contains<u64, Nonce>(&arg0.nonces, arg1)) {
            0x2::table::borrow<u64, Nonce>(&arg0.nonces, arg1).children_filled
        } else {
            0
        }
    }

    public(friend) fun clear_busy(arg0: &mut Account) {
        assert!(is_busy(arg0), 208);
        let v0 = Busy{dummy_field: false};
        0x2::bag::remove<Busy, bool>(&mut arg0.extras, v0);
    }

    public(friend) fun credit(arg0: &mut Account, arg1: 0x1::type_name::TypeName, arg2: u64) {
        if (arg2 == 0) {
            return
        };
        if (0x2::table::contains<0x1::type_name::TypeName, u64>(&arg0.balances, arg1)) {
            let v0 = 0x2::table::borrow_mut<0x1::type_name::TypeName, u64>(&mut arg0.balances, arg1);
            *v0 = *v0 + arg2;
        } else {
            0x2::table::add<0x1::type_name::TypeName, u64>(&mut arg0.balances, arg1, arg2);
        };
    }

    public(friend) fun debit(arg0: &mut Account, arg1: 0x1::type_name::TypeName, arg2: u64) {
        if (arg2 == 0) {
            return
        };
        debit_quietly(arg0, arg1, arg2);
        arg0.seq = arg0.seq + 1;
    }

    public(friend) fun debit_quietly(arg0: &mut Account, arg1: 0x1::type_name::TypeName, arg2: u64) {
        if (arg2 == 0) {
            return
        };
        assert!(balance(arg0, &arg1) >= arg2, 200);
        let v0 = 0x2::table::borrow_mut<0x1::type_name::TypeName, u64>(&mut arg0.balances, arg1);
        *v0 = *v0 - arg2;
        if (*v0 == 0) {
            0x2::table::remove<0x1::type_name::TypeName, u64>(&mut arg0.balances, arg1);
        };
    }

    public fun debt(arg0: &Account) : u64 {
        arg0.debt
    }

    public(friend) fun extras(arg0: &Account) : &0x2::bag::Bag {
        &arg0.extras
    }

    public(friend) fun extras_mut(arg0: &mut Account) : &mut 0x2::bag::Bag {
        &mut arg0.extras
    }

    public(friend) fun fill_nonce(arg0: &mut Account, arg1: u64, arg2: vector<u8>, arg3: u256, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: bool, arg11: 0x1::option::Option<Fire>) {
        if (!0x2::table::contains<u64, Nonce>(&arg0.nonces, arg1)) {
            let v0 = Nonce{
                expiry_ms       : arg5,
                filled          : 0,
                digest          : arg2,
                instrument      : arg3,
                cancelled       : false,
                key_epoch       : arg4,
                children_filled : 0,
                last_fill_ms    : 0,
                fired_at_ms     : 0,
                fired_proof_ms  : 0,
                fired_cover     : 0,
                fired_used      : 0,
            };
            0x2::table::add<u64, Nonce>(&mut arg0.nonces, arg1, v0);
        };
        let v1 = 0x2::table::borrow_mut<u64, Nonce>(&mut arg0.nonces, arg1);
        assert!(!v1.cancelled, 201);
        assert!(v1.digest == arg2, 204);
        let v2 = (v1.filled as u128) + (arg8 as u128);
        assert!(v2 <= (arg6 as u128), 202);
        assert!(v2 >= (arg7 as u128), 203);
        v1.filled = (v2 as u64);
        if (arg8 > 0) {
            v1.last_fill_ms = arg9;
        };
        if (0x1::option::is_some<Fire>(&arg11)) {
            let Fire {
                at_ms    : v3,
                proof_ms : v4,
                cover    : v5,
            } = 0x1::option::destroy_some<Fire>(arg11);
            v1.fired_at_ms = v3;
            v1.fired_proof_ms = v4;
            v1.fired_cover = v5;
            v1.fired_used = 0;
        };
        if (arg10) {
            let v6 = (v1.fired_used as u128) + (arg8 as u128);
            assert!(v6 <= (v1.fired_cover as u128), 209);
            v1.fired_used = (v6 as u64);
        };
    }

    public fun filled(arg0: &Account, arg1: u64) : u64 {
        if (0x2::table::contains<u64, Nonce>(&arg0.nonces, arg1)) {
            0x2::table::borrow<u64, Nonce>(&arg0.nonces, arg1).filled
        } else {
            0
        }
    }

    public(friend) fun fire(arg0: u64, arg1: u64, arg2: u64) : Fire {
        Fire{
            at_ms    : arg0,
            proof_ms : arg1,
            cover    : arg2,
        }
    }

    public fun fired_at_ms(arg0: &Account, arg1: u64) : u64 {
        if (0x2::table::contains<u64, Nonce>(&arg0.nonces, arg1)) {
            0x2::table::borrow<u64, Nonce>(&arg0.nonces, arg1).fired_at_ms
        } else {
            0
        }
    }

    public fun fired_cover(arg0: &Account, arg1: u64) : (u64, u64) {
        if (!0x2::table::contains<u64, Nonce>(&arg0.nonces, arg1)) {
            return (0, 0)
        };
        let v0 = 0x2::table::borrow<u64, Nonce>(&arg0.nonces, arg1);
        (v0.fired_cover, v0.fired_used)
    }

    public fun fired_proof_ms(arg0: &Account, arg1: u64) : u64 {
        if (0x2::table::contains<u64, Nonce>(&arg0.nonces, arg1)) {
            0x2::table::borrow<u64, Nonce>(&arg0.nonces, arg1).fired_proof_ms
        } else {
            0
        }
    }

    public fun holdings(arg0: &Account) : u64 {
        0x2::table::length<0x1::type_name::TypeName, u64>(&arg0.balances)
    }

    public fun is_busy(arg0: &Account) : bool {
        let v0 = Busy{dummy_field: false};
        0x2::bag::contains<Busy>(&arg0.extras, v0)
    }

    public fun is_cancelled(arg0: &Account, arg1: u64) : bool {
        0x2::table::contains<u64, Nonce>(&arg0.nonces, arg1) && 0x2::table::borrow<u64, Nonce>(&arg0.nonces, arg1).cancelled
    }

    public fun is_empty(arg0: &Account) : bool {
        if (0x2::table::length<0x1::type_name::TypeName, u64>(&arg0.balances) == 0) {
            if (arg0.open_positions == 0) {
                !is_busy(arg0)
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun key_epoch(arg0: &Account) : u64 {
        arg0.key_epoch
    }

    public fun last_fill_ms(arg0: &Account, arg1: u64) : u64 {
        if (0x2::table::contains<u64, Nonce>(&arg0.nonces, arg1)) {
            0x2::table::borrow<u64, Nonce>(&arg0.nonces, arg1).last_fill_ms
        } else {
            0
        }
    }

    public fun margin_enabled(arg0: &Account) : bool {
        arg0.margin_enabled
    }

    public fun max_debt(arg0: &Account, arg1: u64) : u64 {
        0x1::option::destroy_with_default<u64>(arg0.max_debt, arg1)
    }

    public fun nonce_instrument(arg0: &Account, arg1: u64) : u256 {
        if (0x2::table::contains<u64, Nonce>(&arg0.nonces, arg1)) {
            0x2::table::borrow<u64, Nonce>(&arg0.nonces, arg1).instrument
        } else {
            0
        }
    }

    public fun nonce_key_epoch(arg0: &Account, arg1: u64) : 0x1::option::Option<u64> {
        if (0x2::table::contains<u64, Nonce>(&arg0.nonces, arg1)) {
            0x1::option::some<u64>(0x2::table::borrow<u64, Nonce>(&arg0.nonces, arg1).key_epoch)
        } else {
            0x1::option::none<u64>()
        }
    }

    public fun open_positions(arg0: &Account) : u64 {
        arg0.open_positions
    }

    public fun penalties(arg0: &Account) : u64 {
        arg0.penalties
    }

    public(friend) fun position_closed(arg0: &mut Account) {
        arg0.open_positions = arg0.open_positions - 1;
    }

    public(friend) fun position_opened(arg0: &mut Account) {
        arg0.open_positions = arg0.open_positions + 1;
    }

    public(friend) fun reclaim_nonce(arg0: &mut Account, arg1: u64, arg2: u64) {
        assert!(0x2::table::contains<u64, Nonce>(&arg0.nonces, arg1), 206);
        assert!(arg2 > 0x2::table::borrow<u64, Nonce>(&arg0.nonces, arg1).expiry_ms, 205);
        0x2::table::remove<u64, Nonce>(&mut arg0.nonces, arg1);
    }

    public fun seq(arg0: &Account) : u64 {
        arg0.seq
    }

    public(friend) fun set_busy(arg0: &mut Account) {
        assert!(!is_busy(arg0), 207);
        let v0 = Busy{dummy_field: false};
        0x2::bag::add<Busy, bool>(&mut arg0.extras, v0, true);
    }

    public(friend) fun set_debt(arg0: &mut Account, arg1: u64) {
        if (arg1 > arg0.debt) {
            arg0.seq = arg0.seq + 1;
        };
        arg0.debt = arg1;
    }

    public(friend) fun set_margin_enabled(arg0: &mut Account, arg1: bool) {
        arg0.margin_enabled = arg1;
    }

    public(friend) fun set_max_debt(arg0: &mut Account, arg1: 0x1::option::Option<u64>) {
        arg0.max_debt = arg1;
    }

    public(friend) fun set_trading_pubkey(arg0: &mut Account, arg1: vector<u8>) {
        arg0.trading_pubkey = arg1;
        arg0.key_epoch = arg0.key_epoch + 1;
    }

    public fun trading_pubkey(arg0: &Account) : &vector<u8> {
        &arg0.trading_pubkey
    }

    // decompiled from Move bytecode v7
}

