module 0xbc2871eadb87e61416de397f9d819f0296ea68b53e2adae90f7654c18fb42cb5::tocen_airdrop {
    struct TocenAirdrop<phantom T0> has store, key {
        id: 0x2::object::UID,
        token_airdrop: 0x2::balance::Balance<T0>,
        timestamp_start: u64,
        timestamp_end: u64,
        total_claim: u64,
    }

    struct EventClaimAirdrop has copy, drop {
        owner_claim: address,
        balance_claim: u64,
    }

    fun checkOwnerSignClaim(arg0: vector<u8>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : bool {
        let v0 = 0x1::string::utf8(b"0x");
        0x1::string::append(&mut v0, 0x2::address::to_string(0x2::tx_context::sender(arg2)));
        let v1 = 0x1::string::utf8(arg0);
        0x1::string::sub_string(&v1, 0, 66) == v0 && 0x1::string::sub_string(&v1, 67, 0x1::string::length(&v1)) == 0x1::string::utf8(numberToStr(arg1))
    }

    public entry fun claim_airdrop<T0>(arg0: &mut TocenAirdrop<T0>, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::dynamic_field::exists_<address>(&arg0.id, 0x2::tx_context::sender(arg5)), 9);
        let v0 = 0xbc2871eadb87e61416de397f9d819f0296ea68b53e2adae90f7654c18fb42cb5::utils::get_key_airdrop();
        assert!(0x2::ed25519::ed25519_verify(&arg1, &v0, &arg2), 12);
        assert!(checkOwnerSignClaim(arg2, arg3, arg5), 13);
        assert!(arg0.timestamp_start <= 0x2::clock::timestamp_ms(arg4), 8);
        assert!(arg0.timestamp_end >= 0x2::clock::timestamp_ms(arg4), 8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.token_airdrop, arg3), arg5), 0x2::tx_context::sender(arg5));
        arg0.total_claim = arg0.total_claim + arg3;
        0x2::dynamic_field::add<address, u64>(&mut arg0.id, 0x2::tx_context::sender(arg5), arg3);
        let v1 = EventClaimAirdrop{
            owner_claim   : 0x2::tx_context::sender(arg5),
            balance_claim : arg3,
        };
        0x2::event::emit<EventClaimAirdrop>(v1);
    }

    public entry fun create_token_airdrop<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        assert!(0xbc2871eadb87e61416de397f9d819f0296ea68b53e2adae90f7654c18fb42cb5::witness::check_owner(arg0), 1);
        let v0 = TocenAirdrop<T0>{
            id              : 0x2::object::new(arg0),
            token_airdrop   : 0x2::balance::zero<T0>(),
            timestamp_start : 0xbc2871eadb87e61416de397f9d819f0296ea68b53e2adae90f7654c18fb42cb5::utils::get_time_start(),
            timestamp_end   : 0xbc2871eadb87e61416de397f9d819f0296ea68b53e2adae90f7654c18fb42cb5::utils::get_time_end(),
            total_claim     : 0,
        };
        0x2::transfer::share_object<TocenAirdrop<T0>>(v0);
    }

    public fun numberToStr(arg0: u64) : vector<u8> {
        let v0 = b"";
        while (arg0 % 10 >= 0 && arg0 > 0) {
            let v1 = b"0123456789";
            0x1::vector::insert<u8>(&mut v0, *0x1::vector::borrow<u8>(&v1, arg0 % 10), 0);
            arg0 = arg0 / 10;
        };
        v0
    }

    public entry fun setup<T0>(arg0: &mut TocenAirdrop<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::dynamic_field::remove<address, u64>(&mut arg0.id, arg1);
    }

    public entry fun token_claimable<T0>(arg0: &mut TocenAirdrop<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0xbc2871eadb87e61416de397f9d819f0296ea68b53e2adae90f7654c18fb42cb5::witness::check_owner(arg3), 1);
        assert!(0x2::coin::value<T0>(&arg1) > 0, 6);
        let v0 = &mut arg0.token_airdrop;
        transferToce<T0>(v0, arg1, arg2, arg3);
    }

    fun transferToce<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg1) >= arg2, 1);
        0x2::balance::join<T0>(arg0, 0x2::balance::split<T0>(0x2::coin::balance_mut<T0>(&mut arg1), arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg3));
    }

    public entry fun update_time<T0>(arg0: &mut TocenAirdrop<T0>, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0xbc2871eadb87e61416de397f9d819f0296ea68b53e2adae90f7654c18fb42cb5::witness::check_owner(arg3), 1);
        if (arg1 == 1) {
            arg0.timestamp_start = arg2;
        } else if (arg1 == 2) {
            arg0.timestamp_end = arg2;
        };
    }

    public entry fun witht<T0>(arg0: &mut TocenAirdrop<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0xbc2871eadb87e61416de397f9d819f0296ea68b53e2adae90f7654c18fb42cb5::witness::check_owner(arg2), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.token_airdrop, arg1), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

