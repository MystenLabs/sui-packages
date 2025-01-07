module 0x3ff3796968384d673e084c1f1d7b90f447825bcd057bce63693b968e971de05d::drf_vesting {
    struct VestingStorage<phantom T0> has key {
        id: 0x2::object::UID,
        amount: u64,
        totalPeriods: u64,
        completedPeriods: u64,
        amountPerPeriod: u64,
        canceledAt: u64,
        cliffAmount: u64,
        canceled: bool,
        created: u64,
        end: u64,
        lastWithdrawanAt: u64,
        sender: address,
        recipient: address,
        start: u64,
        withdrawn: u64,
        timestamps: vector<u64>,
        balance: 0x2::balance::Balance<T0>,
    }

    public entry fun cancel<T0>(arg0: &0x2::clock::Clock, arg1: &mut VestingStorage<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        arg1.canceled = true;
        arg1.canceledAt = 0x2::clock::timestamp_ms(arg0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.balance, 0x2::balance::value<T0>(&arg1.balance), arg2), arg1.sender);
    }

    public entry fun create_vesting<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: &0x2::clock::Clock, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: address, arg8: address, arg9: u64, arg10: u8, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = VestingStorage<T0>{
            id               : 0x2::object::new(arg11),
            amount           : arg2,
            totalPeriods     : arg3,
            completedPeriods : 0,
            amountPerPeriod  : arg4,
            canceledAt       : 0,
            cliffAmount      : arg5,
            canceled         : false,
            created          : 0x2::clock::timestamp_ms(arg1),
            end              : arg6,
            lastWithdrawanAt : 0,
            sender           : arg7,
            recipient        : arg8,
            start            : arg9,
            withdrawn        : 0,
            timestamps       : get_timestampes(arg10, arg3, arg9),
            balance          : 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg0, arg2, arg11)),
        };
        if (arg5 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg0, arg5, arg11), arg8);
        };
        0x2::transfer::share_object<VestingStorage<T0>>(v0);
    }

    fun get_timestampes(arg0: u8, arg1: u64, arg2: u64) : vector<u64> {
        let v0 = 0x1::vector::empty<u64>();
        if (arg0 == 0) {
            let v1 = 1;
            while (v1 <= arg1) {
                0x1::vector::push_back<u64>(&mut v0, arg2 + v1 * 86400000);
                v1 = v1 + 1;
            };
        } else if (arg0 == 1) {
            let v2 = 1;
            while (v2 <= arg1) {
                0x1::vector::push_back<u64>(&mut v0, arg2 + v2 * 604800000);
                v2 = v2 + 1;
            };
        } else if (arg0 == 2) {
            let v3 = 1;
            while (v3 <= arg1) {
                0x1::vector::push_back<u64>(&mut v0, arg2 + v3 * 2592000000);
                v3 = v3 + 1;
            };
        } else {
            let v4 = 0;
            while (v4 < arg1) {
                0x1::vector::push_back<u64>(&mut v0, arg2 + v4 * 31536000000);
                v4 = v4 + 1;
            };
        };
        v0
    }

    fun get_withdrawal<T0>(arg0: &0x2::clock::Clock, arg1: &mut VestingStorage<T0>) : (u64, u64) {
        let v0 = arg1.timestamps;
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        while (v1 < 0x1::vector::length<u64>(&v0)) {
            if (*0x1::vector::borrow<u64>(&v0, v1) <= 0x2::clock::timestamp_ms(arg0)) {
                v2 = v2 + 1;
            };
            v1 = v1 + 1;
        };
        if (v2 > 0) {
            let v5 = v2 - arg1.completedPeriods;
            v3 = v5;
            v4 = v5 * arg1.amountPerPeriod;
        };
        (v3, v4)
    }

    public entry fun withdraw<T0>(arg0: &0x2::clock::Clock, arg1: &mut VestingStorage<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = get_withdrawal<T0>(arg0, arg1);
        if (v0 > 0) {
            arg1.completedPeriods = arg1.completedPeriods + v0;
            arg1.lastWithdrawanAt = 0x2::clock::timestamp_ms(arg0);
            arg1.withdrawn = v1;
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.balance, v1, arg2), arg1.recipient);
        };
    }

    // decompiled from Move bytecode v6
}

