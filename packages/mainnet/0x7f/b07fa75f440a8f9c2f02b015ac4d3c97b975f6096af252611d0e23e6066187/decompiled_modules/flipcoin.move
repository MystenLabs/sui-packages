module 0x7fb07fa75f440a8f9c2f02b015ac4d3c97b975f6096af252611d0e23e6066187::flipcoin {
    struct FlipCoin has store, key {
        id: 0x2::object::UID,
        admin_address: address,
        fee: u64,
    }

    struct Ticket has copy, drop {
        guess: 0x1::string::String,
        result: 0x1::string::String,
        status: 0x1::string::String,
    }

    struct TicketGuessNumber has copy, drop {
        guess: u64,
        result: u64,
        status: 0x1::string::String,
    }

    public entry fun add_first_liquidity(arg0: &mut FlipCoin, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0x9aade983602d59bca76ec5a3f9f40f4a281ed20de3c163937af6d249514ac500, 0);
        0x2::dynamic_object_field::add<bool, 0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0.id, true, arg1);
    }

    public entry fun add_more_liquidity(arg0: &mut FlipCoin, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0x9aade983602d59bca76ec5a3f9f40f4a281ed20de3c163937af6d249514ac500, 0);
        let v0 = 0x1::vector::empty<0x2::coin::Coin<0x2::sui::SUI>>();
        0x1::vector::push_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut v0, arg1);
        0x1::vector::push_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut v0, 0x2::dynamic_object_field::remove<bool, 0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0.id, true));
        let v1 = 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut v0);
        0x2::pay::join_vec<0x2::sui::SUI>(&mut v1, v0);
        0x2::dynamic_object_field::add<bool, 0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0.id, true, v1);
    }

    public entry fun change_admin_address(arg0: &mut FlipCoin, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0x9aade983602d59bca76ec5a3f9f40f4a281ed20de3c163937af6d249514ac500, 0);
        arg0.admin_address = 0x2::address::from_bytes(arg1);
    }

    public entry fun change_fee(arg0: &mut FlipCoin, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0x9aade983602d59bca76ec5a3f9f40f4a281ed20de3c163937af6d249514ac500, 0);
        arg0.fee = arg1;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = FlipCoin{
            id            : 0x2::object::new(arg0),
            admin_address : @0x9aade983602d59bca76ec5a3f9f40f4a281ed20de3c163937af6d249514ac500,
            fee           : 5,
        };
        0x2::transfer::share_object<FlipCoin>(v0);
    }

    public entry fun play(arg0: &mut FlipCoin, arg1: 0x1::string::String, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x1::string::utf8(b"");
        0x1::string::utf8(b"");
        let v0 = if (0x2::clock::timestamp_ms(arg3) % 2 == 1) {
            0x1::string::utf8(b"TAIL")
        } else {
            0x1::string::utf8(b"HEAD")
        };
        let v1 = if (arg1 == v0) {
            let v2 = 0x2::dynamic_object_field::remove<bool, 0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0.id, true);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v2, (100 - arg0.fee) * 0x2::coin::value<0x2::sui::SUI>(&arg2) / 100, arg4), 0x2::tx_context::sender(arg4));
            0x2::dynamic_object_field::add<bool, 0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0.id, true, v2);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, @0x9aade983602d59bca76ec5a3f9f40f4a281ed20de3c163937af6d249514ac500);
            0x1::string::utf8(b"WIN")
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, arg0.admin_address);
            0x1::string::utf8(b"LOSS")
        };
        let v3 = Ticket{
            guess  : arg1,
            result : v0,
            status : v1,
        };
        0x2::event::emit<Ticket>(v3);
    }

    public entry fun play_guess_number(arg0: &mut FlipCoin, arg1: u64, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x7fb07fa75f440a8f9c2f02b015ac4d3c97b975f6096af252611d0e23e6066187::random::get_last_number(0x2::clock::timestamp_ms(arg3));
        0x1::string::utf8(b"");
        let v1 = if (v0 == arg1) {
            let v2 = 0x2::dynamic_object_field::remove<bool, 0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0.id, true);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v2, 10 * (100 - arg0.fee) * 0x2::coin::value<0x2::sui::SUI>(&arg2) / 100, arg4), 0x2::tx_context::sender(arg4));
            0x2::dynamic_object_field::add<bool, 0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0.id, true, v2);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, @0x9aade983602d59bca76ec5a3f9f40f4a281ed20de3c163937af6d249514ac500);
            0x1::string::utf8(b"WIN")
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, @0x9aade983602d59bca76ec5a3f9f40f4a281ed20de3c163937af6d249514ac500);
            0x1::string::utf8(b"LOSS")
        };
        let v3 = TicketGuessNumber{
            guess  : arg1,
            result : v0,
            status : v1,
        };
        0x2::event::emit<TicketGuessNumber>(v3);
    }

    public entry fun remove_liquidity(arg0: &mut FlipCoin, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0x9aade983602d59bca76ec5a3f9f40f4a281ed20de3c163937af6d249514ac500, 0);
        let v0 = 0x2::dynamic_object_field::remove<bool, 0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0.id, true);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v0, arg1, arg2), 0x2::tx_context::sender(arg2));
        0x2::dynamic_object_field::add<bool, 0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0.id, true, v0);
    }

    // decompiled from Move bytecode v6
}

