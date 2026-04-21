module 0xab1daf7c2a12177345d6bf9379756b849d4ed53b95c41fb896bf357ba037d5ed::faucet {
    struct Faucet has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0xab1daf7c2a12177345d6bf9379756b849d4ed53b95c41fb896bf357ba037d5ed::fsui::FSUI>,
        record: 0x2::table::Table<address, u64>,
        supply: 0x2::balance::Supply<0xab1daf7c2a12177345d6bf9379756b849d4ed53b95c41fb896bf357ba037d5ed::fsui::FSUI>,
        duration: u64,
        amount_per_claim: u64,
    }

    public fun claim(arg0: &mut Faucet, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xab1daf7c2a12177345d6bf9379756b849d4ed53b95c41fb896bf357ba037d5ed::fsui::FSUI> {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        if (0x2::table::contains<address, u64>(&arg0.record, 0x2::tx_context::sender(arg2))) {
            let v1 = 0x2::table::borrow_mut<address, u64>(&mut arg0.record, 0x2::tx_context::sender(arg2));
            if (v0 - *v1 < arg0.duration) {
                abort 0
            };
            *v1 = v0;
        } else {
            0x2::table::add<address, u64>(&mut arg0.record, 0x2::tx_context::sender(arg2), v0);
        };
        0x2::coin::from_balance<0xab1daf7c2a12177345d6bf9379756b849d4ed53b95c41fb896bf357ba037d5ed::fsui::FSUI>(0x2::balance::increase_supply<0xab1daf7c2a12177345d6bf9379756b849d4ed53b95c41fb896bf357ba037d5ed::fsui::FSUI>(&mut arg0.supply, arg0.amount_per_claim), arg2)
    }

    public fun new_faucet(arg0: 0x2::coin::TreasuryCap<0xab1daf7c2a12177345d6bf9379756b849d4ed53b95c41fb896bf357ba037d5ed::fsui::FSUI>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Faucet{
            id               : 0x2::object::new(arg1),
            balance          : 0x2::balance::zero<0xab1daf7c2a12177345d6bf9379756b849d4ed53b95c41fb896bf357ba037d5ed::fsui::FSUI>(),
            record           : 0x2::table::new<address, u64>(arg1),
            supply           : 0x2::coin::treasury_into_supply<0xab1daf7c2a12177345d6bf9379756b849d4ed53b95c41fb896bf357ba037d5ed::fsui::FSUI>(arg0),
            duration         : 86400000,
            amount_per_claim : 1000000000000,
        };
        0x2::transfer::share_object<Faucet>(v0);
    }

    // decompiled from Move bytecode v6
}

