module 0xd5cd31f4bf84a2c280c9ed20cbb20345cbe5c1ebe63014c406f97b20edd4ac63::linear_vesting_wallet_clawback {
    struct Wallet<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        released: u64,
        start: u64,
        duration: u64,
        clawbacked: u64,
    }

    struct RecipientWitness has drop {
        dummy_field: bool,
    }

    struct ClawBackWitness has drop {
        dummy_field: bool,
    }

    public fun balance<T0>(arg0: &Wallet<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun destroy_zero<T0>(arg0: Wallet<T0>) {
        let Wallet {
            id         : v0,
            balance    : v1,
            released   : _,
            start      : _,
            duration   : _,
            clawbacked : _,
        } = arg0;
        0x2::object::delete(v0);
        0x2::balance::destroy_zero<T0>(v1);
    }

    public fun new<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0x2::clock::Clock, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (0xd5cd31f4bf84a2c280c9ed20cbb20345cbe5c1ebe63014c406f97b20edd4ac63::owner::OwnerCap<ClawBackWitness>, 0xd5cd31f4bf84a2c280c9ed20cbb20345cbe5c1ebe63014c406f97b20edd4ac63::owner::OwnerCap<RecipientWitness>, Wallet<T0>) {
        assert!(arg2 >= 0x2::clock::timestamp_ms(arg1), 0);
        let v0 = Wallet<T0>{
            id         : 0x2::object::new(arg4),
            balance    : 0x2::coin::into_balance<T0>(arg0),
            released   : 0,
            start      : arg2,
            duration   : arg3,
            clawbacked : 0,
        };
        let v1 = ClawBackWitness{dummy_field: false};
        let v2 = 0x1::vector::empty<0x2::object::ID>();
        0x1::vector::push_back<0x2::object::ID>(&mut v2, 0x2::object::id<Wallet<T0>>(&v0));
        let v3 = RecipientWitness{dummy_field: false};
        let v4 = 0x1::vector::empty<0x2::object::ID>();
        0x1::vector::push_back<0x2::object::ID>(&mut v4, 0x2::object::id<Wallet<T0>>(&v0));
        (0xd5cd31f4bf84a2c280c9ed20cbb20345cbe5c1ebe63014c406f97b20edd4ac63::owner::new<ClawBackWitness>(v1, v2, arg4), 0xd5cd31f4bf84a2c280c9ed20cbb20345cbe5c1ebe63014c406f97b20edd4ac63::owner::new<RecipientWitness>(v3, v4, arg4), v0)
    }

    public fun claim<T0>(arg0: &mut Wallet<T0>, arg1: &0xd5cd31f4bf84a2c280c9ed20cbb20345cbe5c1ebe63014c406f97b20edd4ac63::owner::OwnerCap<RecipientWitness>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xd5cd31f4bf84a2c280c9ed20cbb20345cbe5c1ebe63014c406f97b20edd4ac63::owner::assert_ownership<RecipientWitness>(arg1, 0x2::object::id<Wallet<T0>>(arg0));
        let v0 = vesting_status<T0>(arg0, arg2);
        arg0.released = arg0.released + v0;
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, 0xd5cd31f4bf84a2c280c9ed20cbb20345cbe5c1ebe63014c406f97b20edd4ac63::math64::min(v0, 0x2::balance::value<T0>(&arg0.balance))), arg3)
    }

    public fun clawback<T0>(arg0: &mut Wallet<T0>, arg1: 0xd5cd31f4bf84a2c280c9ed20cbb20345cbe5c1ebe63014c406f97b20edd4ac63::owner::OwnerCap<ClawBackWitness>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xd5cd31f4bf84a2c280c9ed20cbb20345cbe5c1ebe63014c406f97b20edd4ac63::owner::assert_ownership<ClawBackWitness>(&arg1, 0x2::object::id<Wallet<T0>>(arg0));
        0xd5cd31f4bf84a2c280c9ed20cbb20345cbe5c1ebe63014c406f97b20edd4ac63::owner::destroy<ClawBackWitness>(arg1);
        let v0 = 0x2::balance::value<T0>(&arg0.balance) - vesting_status<T0>(arg0, arg2);
        arg0.clawbacked = v0;
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, v0), arg3)
    }

    public fun clawbacked<T0>(arg0: &Wallet<T0>) : u64 {
        arg0.clawbacked
    }

    public fun duration<T0>(arg0: &Wallet<T0>) : u64 {
        arg0.duration
    }

    public fun released<T0>(arg0: &Wallet<T0>) : u64 {
        arg0.released
    }

    public fun share<T0>(arg0: Wallet<T0>) {
        0x2::transfer::share_object<Wallet<T0>>(arg0);
    }

    public fun start<T0>(arg0: &Wallet<T0>) : u64 {
        arg0.start
    }

    public fun vesting_status<T0>(arg0: &Wallet<T0>, arg1: &0x2::clock::Clock) : u64 {
        0xd5cd31f4bf84a2c280c9ed20cbb20345cbe5c1ebe63014c406f97b20edd4ac63::vesting::linear_vested_amount(arg0.start, arg0.duration, 0x2::balance::value<T0>(&arg0.balance) + arg0.clawbacked, arg0.released, 0x2::clock::timestamp_ms(arg1)) - arg0.released
    }

    // decompiled from Move bytecode v6
}

