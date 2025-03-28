module 0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_exchange_rate {
    struct ExchangeRate has copy, drop, store {
        lst: u128,
        wal: u128,
    }

    public(friend) fun empty() : ExchangeRate {
        ExchangeRate{
            lst : 0,
            wal : 0,
        }
    }

    public(friend) fun add_wal_down(arg0: &mut ExchangeRate, arg1: u64) : u64 {
        let v0 = to_lst_down(arg0, arg1);
        arg0.wal = arg0.wal + (arg1 as u128);
        arg0.lst = arg0.lst + (v0 as u128);
        v0
    }

    public(friend) fun is_empty(arg0: ExchangeRate) : bool {
        arg0.wal == 0
    }

    public(friend) fun lst(arg0: ExchangeRate) : u64 {
        (arg0.lst as u64)
    }

    public(friend) fun new(arg0: u64, arg1: u64) : ExchangeRate {
        ExchangeRate{
            lst : (arg1 as u128),
            wal : (arg0 as u128),
        }
    }

    public(friend) fun sub_lst_down(arg0: &mut ExchangeRate, arg1: u64) : u64 {
        let v0 = to_wal_down(arg0, arg1);
        arg0.wal = arg0.wal - (v0 as u128);
        arg0.lst = arg0.lst - (arg1 as u128);
        v0
    }

    public(friend) fun sub_wal_down(arg0: &mut ExchangeRate, arg1: u64) : u64 {
        let v0 = to_lst_down(arg0, arg1);
        arg0.wal = arg0.wal - (arg1 as u128);
        arg0.lst = arg0.lst - (v0 as u128);
        v0
    }

    public(friend) fun sub_wal_up(arg0: &mut ExchangeRate, arg1: u64) : u64 {
        let v0 = to_lst_up(arg0, arg1);
        arg0.wal = arg0.wal - (arg1 as u128);
        arg0.lst = arg0.lst - (v0 as u128);
        v0
    }

    public(friend) fun to_lst_down(arg0: &ExchangeRate, arg1: u64) : u64 {
        if (arg0.wal == 0) {
            return arg1
        };
        (0x7853a6de8198d75894e4376bdd8c6349dda7446345de6454feb6fab6ed26ef91::u128::mul_div_down((arg1 as u128), arg0.lst, arg0.wal) as u64)
    }

    public(friend) fun to_lst_up(arg0: &ExchangeRate, arg1: u64) : u64 {
        if (arg0.wal == 0) {
            return arg1
        };
        (0x7853a6de8198d75894e4376bdd8c6349dda7446345de6454feb6fab6ed26ef91::u128::mul_div_up((arg1 as u128), arg0.lst, arg0.wal) as u64)
    }

    public(friend) fun to_wal_down(arg0: &ExchangeRate, arg1: u64) : u64 {
        if (arg0.lst == 0) {
            return arg1
        };
        (0x7853a6de8198d75894e4376bdd8c6349dda7446345de6454feb6fab6ed26ef91::u128::mul_div_down((arg1 as u128), arg0.wal, arg0.lst) as u64)
    }

    public(friend) fun to_wal_up(arg0: &ExchangeRate, arg1: u64) : u64 {
        if (arg0.lst == 0) {
            return arg1
        };
        (0x7853a6de8198d75894e4376bdd8c6349dda7446345de6454feb6fab6ed26ef91::u128::mul_div_up((arg1 as u128), arg0.wal, arg0.lst) as u64)
    }

    public(friend) fun wal(arg0: ExchangeRate) : u64 {
        (arg0.wal as u64)
    }

    // decompiled from Move bytecode v6
}

