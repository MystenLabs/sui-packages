module 0x83036adcd9010ad52655fd2b9ca9889a90a00eb937427e8d396c4cc5868d0e3f::seal_pay_id_capability {
    struct SealPayStation<phantom T0> has key {
        id: 0x2::object::UID,
        beneficiary: address,
        total_payments: u64,
        amount: u64,
        balance: 0x2::balance::Balance<T0>,
    }

    struct PayStationTicket has store, key {
        id: 0x2::object::UID,
        station_id: 0x2::object::ID,
    }

    struct PayStationCreated has copy, drop {
        station_id: 0x2::object::ID,
        ticket_id: 0x2::object::ID,
        beneficiary: address,
        amount: u64,
    }

    struct PaymentReceived has copy, drop {
        station_id: 0x2::object::ID,
        payer: address,
        amount: u64,
        payment_number: u64,
    }

    struct FundsWithdrawn has copy, drop {
        station_id: 0x2::object::ID,
        beneficiary: address,
        amount: u64,
    }

    struct AccessGranted has copy, drop {
        station_id: 0x2::object::ID,
        beneficiary: address,
        recipient: address,
    }

    struct PayStationDeleted has copy, drop {
        station_id: 0x2::object::ID,
        beneficiary: address,
        remaining_balance: u64,
    }

    struct PriceUpdated has copy, drop {
        station_id: 0x2::object::ID,
        old_amount: u64,
        new_amount: u64,
    }

    struct BeneficiaryUpdated has copy, drop {
        station_id: 0x2::object::ID,
        old_beneficiary: address,
        new_beneficiary: address,
    }

    public fun create_pay_station<T0>(arg0: address, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg2);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = SealPayStation<T0>{
            id             : v0,
            beneficiary    : arg0,
            total_payments : 0,
            amount         : arg1,
            balance        : 0x2::balance::zero<T0>(),
        };
        let v3 = PayStationTicket{
            id         : 0x2::object::new(arg2),
            station_id : v1,
        };
        let v4 = PayStationCreated{
            station_id  : v1,
            ticket_id   : 0x2::object::uid_to_inner(&v3.id),
            beneficiary : arg0,
            amount      : arg1,
        };
        0x2::event::emit<PayStationCreated>(v4);
        0x2::transfer::share_object<SealPayStation<T0>>(v2);
        0x2::transfer::transfer<PayStationTicket>(v3, arg0);
    }

    public fun delete_pay_station<T0>(arg0: SealPayStation<T0>, arg1: PayStationTicket, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.beneficiary, 1);
        assert!(arg1.station_id == 0x2::object::id<SealPayStation<T0>>(&arg0), 2);
        let SealPayStation {
            id             : v0,
            beneficiary    : v1,
            total_payments : _,
            amount         : _,
            balance        : v4,
        } = arg0;
        let v5 = v4;
        let v6 = v0;
        let PayStationTicket {
            id         : v7,
            station_id : _,
        } = arg1;
        let v9 = 0x2::balance::value<T0>(&v5);
        let v10 = PayStationDeleted{
            station_id        : 0x2::object::uid_to_inner(&v6),
            beneficiary       : v1,
            remaining_balance : v9,
        };
        0x2::event::emit<PayStationDeleted>(v10);
        if (v9 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v5, arg2), v1);
        } else {
            0x2::balance::destroy_zero<T0>(v5);
        };
        0x2::object::delete(v6);
        0x2::object::delete(v7);
    }

    public fun get_amount<T0>(arg0: &SealPayStation<T0>) : u64 {
        arg0.amount
    }

    public fun get_balance<T0>(arg0: &SealPayStation<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun get_beneficiary<T0>(arg0: &SealPayStation<T0>) : address {
        arg0.beneficiary
    }

    public fun get_station_id(arg0: &PayStationTicket) : 0x2::object::ID {
        arg0.station_id
    }

    public fun get_total_payments<T0>(arg0: &SealPayStation<T0>) : u64 {
        arg0.total_payments
    }

    public fun grant_access<T0>(arg0: &mut SealPayStation<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.beneficiary, 1);
        let v0 = AccessGranted{
            station_id  : 0x2::object::id<SealPayStation<T0>>(arg0),
            beneficiary : 0x2::tx_context::sender(arg2),
            recipient   : arg1,
        };
        0x2::event::emit<AccessGranted>(v0);
        0x2::transfer::public_transfer<0x83036adcd9010ad52655fd2b9ca9889a90a00eb937427e8d396c4cc5868d0e3f::seal_object_id_capability::ObjectIdDecryptionCapability>(0x83036adcd9010ad52655fd2b9ca9889a90a00eb937427e8d396c4cc5868d0e3f::seal_object_id_capability::create_capability(&mut arg0.id, arg2), arg1);
    }

    public fun pay_for_access<T0>(arg0: &mut SealPayStation<T0>, arg1: &mut 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x83036adcd9010ad52655fd2b9ca9889a90a00eb937427e8d396c4cc5868d0e3f::seal_object_id_capability::ObjectIdDecryptionCapability {
        assert!(0x2::coin::value<T0>(arg1) >= arg0.amount, 0);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg1, arg0.amount, arg2)));
        arg0.total_payments = arg0.total_payments + 1;
        let v0 = PaymentReceived{
            station_id     : 0x2::object::id<SealPayStation<T0>>(arg0),
            payer          : 0x2::tx_context::sender(arg2),
            amount         : arg0.amount,
            payment_number : arg0.total_payments,
        };
        0x2::event::emit<PaymentReceived>(v0);
        0x83036adcd9010ad52655fd2b9ca9889a90a00eb937427e8d396c4cc5868d0e3f::seal_object_id_capability::create_capability(&mut arg0.id, arg2)
    }

    public fun update_beneficiary<T0>(arg0: &mut SealPayStation<T0>, arg1: PayStationTicket, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.beneficiary, 1);
        assert!(arg1.station_id == 0x2::object::id<SealPayStation<T0>>(arg0), 2);
        arg0.beneficiary = arg2;
        let v0 = BeneficiaryUpdated{
            station_id      : 0x2::object::id<SealPayStation<T0>>(arg0),
            old_beneficiary : arg0.beneficiary,
            new_beneficiary : arg2,
        };
        0x2::event::emit<BeneficiaryUpdated>(v0);
        0x2::transfer::public_transfer<PayStationTicket>(arg1, arg2);
    }

    public fun update_price<T0>(arg0: &mut SealPayStation<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.beneficiary, 1);
        arg0.amount = arg1;
        let v0 = PriceUpdated{
            station_id : 0x2::object::id<SealPayStation<T0>>(arg0),
            old_amount : arg0.amount,
            new_amount : arg1,
        };
        0x2::event::emit<PriceUpdated>(v0);
    }

    public fun withdraw<T0>(arg0: &mut SealPayStation<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::tx_context::sender(arg1) == arg0.beneficiary, 1);
        let v0 = 0x2::balance::value<T0>(&arg0.balance);
        let v1 = FundsWithdrawn{
            station_id  : 0x2::object::id<SealPayStation<T0>>(arg0),
            beneficiary : 0x2::tx_context::sender(arg1),
            amount      : v0,
        };
        0x2::event::emit<FundsWithdrawn>(v1);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, v0), arg1)
    }

    // decompiled from Move bytecode v6
}

