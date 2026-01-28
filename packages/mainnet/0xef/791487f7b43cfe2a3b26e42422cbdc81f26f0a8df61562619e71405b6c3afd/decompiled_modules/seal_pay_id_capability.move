module 0xef791487f7b43cfe2a3b26e42422cbdc81f26f0a8df61562619e71405b6c3afd::seal_pay_id_capability {
    struct SealPayStation<phantom T0> has key {
        id: 0x2::object::UID,
        beneficiary: address,
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

    public fun create_pay_station<T0>(arg0: address, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg2);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = SealPayStation<T0>{
            id          : v0,
            beneficiary : arg0,
            amount      : arg1,
            balance     : 0x2::balance::zero<T0>(),
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

    public fun grant_access<T0>(arg0: &mut SealPayStation<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.beneficiary, 1);
        let v0 = AccessGranted{
            station_id  : 0x2::object::id<SealPayStation<T0>>(arg0),
            beneficiary : 0x2::tx_context::sender(arg2),
            recipient   : arg1,
        };
        0x2::event::emit<AccessGranted>(v0);
        0x2::transfer::public_transfer<0xef791487f7b43cfe2a3b26e42422cbdc81f26f0a8df61562619e71405b6c3afd::seal_object_id_capability::ObjectIdDecryptionCapability>(0xef791487f7b43cfe2a3b26e42422cbdc81f26f0a8df61562619e71405b6c3afd::seal_object_id_capability::create_capability(&mut arg0.id, arg2), arg1);
    }

    public fun pay_for_access<T0>(arg0: &mut SealPayStation<T0>, arg1: &mut 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0xef791487f7b43cfe2a3b26e42422cbdc81f26f0a8df61562619e71405b6c3afd::seal_object_id_capability::ObjectIdDecryptionCapability {
        assert!(0x2::coin::value<T0>(arg1) >= arg0.amount, 0);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg1, arg0.amount, arg2)));
        let v0 = PaymentReceived{
            station_id : 0x2::object::id<SealPayStation<T0>>(arg0),
            payer      : 0x2::tx_context::sender(arg2),
            amount     : arg0.amount,
        };
        0x2::event::emit<PaymentReceived>(v0);
        0xef791487f7b43cfe2a3b26e42422cbdc81f26f0a8df61562619e71405b6c3afd::seal_object_id_capability::create_capability(&mut arg0.id, arg2)
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

