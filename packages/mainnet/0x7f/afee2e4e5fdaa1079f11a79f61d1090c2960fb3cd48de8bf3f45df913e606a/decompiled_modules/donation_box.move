module 0x7fafee2e4e5fdaa1079f11a79f61d1090c2960fb3cd48de8bf3f45df913e606a::donation_box {
    struct DonationEvent has copy, drop {
        donor: address,
        amount: u64,
    }

    struct DonationBox has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        records: 0x2::table::Table<address, u64>,
    }

    public fun box_balance(arg0: &DonationBox) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    public fun donate(arg0: &mut DonationBox, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        let v1 = &mut arg0.records;
        let v2 = 0x2::tx_context::sender(arg2);
        if (!0x2::table::contains<address, u64>(v1, v2)) {
            0x2::table::add<address, u64>(v1, v2, 0);
        };
        let v3 = 0x2::table::borrow_mut<address, u64>(v1, v2);
        *v3 = *v3 + v0;
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.balance, arg1);
        let v4 = DonationEvent{
            donor  : v2,
            amount : v0,
        };
        0x2::event::emit<DonationEvent>(v4);
    }

    public fun donation_amount(arg0: &DonationBox, arg1: address) : u64 {
        let v0 = &arg0.records;
        if (0x2::table::contains<address, u64>(v0, arg1)) {
            *0x2::table::borrow<address, u64>(v0, arg1)
        } else {
            0
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = DonationBox{
            id      : 0x2::object::new(arg0),
            balance : 0x2::balance::zero<0x2::sui::SUI>(),
            records : 0x2::table::new<address, u64>(arg0),
        };
        0x2::transfer::share_object<DonationBox>(v0);
    }

    public fun withraw_from_box(arg0: &0x7fafee2e4e5fdaa1079f11a79f61d1090c2960fb3cd48de8bf3f45df913e606a::config::AdminCap, arg1: &mut DonationBox, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.balance, arg2, arg4), arg3);
    }

    // decompiled from Move bytecode v6
}

