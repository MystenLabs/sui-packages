module 0x6d8f4e3673bbb30047d7cec7c5fd2ad0ee6b74743a136514daa1bf989f1a6cdd::flow_raffle {
    struct GlobalConfig has key {
        id: 0x2::object::UID,
        fee_percentage: u64,
        fee_address: address,
        admin_addresses: vector<address>,
        is_initialized: bool,
    }

    struct Raffle has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        creator: address,
        ticket_price: u64,
        max_tickets: u64,
        tickets_sold: u64,
        end_time: u64,
        active: bool,
        nft_type: 0x1::string::String,
        nft_id: 0x1::string::String,
        winner_address: 0x1::option::Option<address>,
        prize_claimed: bool,
        ticket_holders: vector<address>,
    }

    struct RaffleCreated has copy, drop {
        raffle_id: 0x2::object::ID,
        creator: address,
        nft_held_id: 0x1::string::String,
        ticket_price: u64,
        max_tickets: u64,
        end_time: u64,
    }

    struct TicketPurchased has copy, drop {
        raffle_id: 0x2::object::ID,
        buyer: address,
        ticket_number: u64,
    }

    struct RaffleEnded has copy, drop {
        raffle_id: 0x2::object::ID,
        winner: address,
        nft_id: 0x1::string::String,
    }

    public entry fun add_admin(arg0: &mut GlobalConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.is_initialized, 4);
        assert!(is_admin(arg0, 0x2::tx_context::sender(arg2)), 4);
        assert!(arg1 != @0x0, 1);
        assert!(!0x1::vector::contains<address>(&arg0.admin_addresses, &arg1), 1);
        assert!(0x1::vector::length<address>(&arg0.admin_addresses) < 10, 5);
        0x1::vector::push_back<address>(&mut arg0.admin_addresses, arg1);
    }

    public entry fun buy_ticket(arg0: &GlobalConfig, arg1: &mut Raffle, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.is_initialized, 4);
        validate_ticket_purchase_status(arg1, 0x2::clock::timestamp_ms(arg3));
        let v0 = arg1.ticket_price;
        assert!(0x2::coin::value<0x2::sui::SUI>(arg2) >= v0, 16);
        assert!(arg0.fee_percentage <= 1000, 4);
        let v1 = v0 * arg0.fee_percentage / 10000;
        if (v1 > 0 && v1 < v0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg2, v1, arg4), arg0.fee_address);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg2, v0 - v1, arg4), arg1.creator);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg2, v0, arg4), arg1.creator);
        };
        let v2 = 0x2::tx_context::sender(arg4);
        0x1::vector::push_back<address>(&mut arg1.ticket_holders, v2);
        arg1.tickets_sold = arg1.tickets_sold + 1;
        let v3 = TicketPurchased{
            raffle_id     : 0x2::object::id<Raffle>(arg1),
            buyer         : v2,
            ticket_number : arg1.tickets_sold,
        };
        0x2::event::emit<TicketPurchased>(v3);
    }

    public fun can_buy_tickets(arg0: &Raffle, arg1: &0x2::clock::Clock) : bool {
        if (arg0.active) {
            if (0x2::clock::timestamp_ms(arg1) < arg0.end_time) {
                if (arg0.tickets_sold < arg0.max_tickets) {
                    0x1::option::is_none<address>(&arg0.winner_address)
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun can_claim_prize(arg0: &Raffle, arg1: address) : bool {
        if (!arg0.active) {
            if (0x1::option::is_some<address>(&arg0.winner_address)) {
                if (*0x1::option::borrow<address>(&arg0.winner_address) == arg1) {
                    !arg0.prize_claimed
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun can_draw_winner(arg0: &Raffle, arg1: &0x2::clock::Clock) : bool {
        if (arg0.active) {
            if (arg0.tickets_sold > 0) {
                if (0x2::clock::timestamp_ms(arg1) >= arg0.end_time || arg0.tickets_sold >= arg0.max_tickets) {
                    0x1::option::is_none<address>(&arg0.winner_address)
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        }
    }

    public entry fun claim_prize<T0: store + key>(arg0: &mut Raffle, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        validate_prize_claim_status(arg0, v0);
        if (0x2::dynamic_object_field::exists_<vector<u8>>(&arg0.id, b"nft")) {
            0x2::transfer::public_transfer<T0>(0x2::dynamic_object_field::remove<vector<u8>, T0>(&mut arg0.id, b"nft"), v0);
            arg0.prize_claimed = true;
        };
    }

    public entry fun create_raffle<T0: store + key>(arg0: T0, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 > 0, 9);
        assert!(arg3 <= 1000000000000, 9);
        assert!(arg4 > 0, 10);
        assert!(arg5 > 0 && arg5 <= 720, 11);
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = 0x2::clock::timestamp_ms(arg6) + arg5 * 3600000;
        let v2 = Raffle{
            id             : 0x2::object::new(arg7),
            name           : 0x1::string::utf8(arg1),
            description    : 0x1::string::utf8(arg2),
            creator        : v0,
            ticket_price   : arg3,
            max_tickets    : arg4,
            tickets_sold   : 0,
            end_time       : v1,
            active         : true,
            nft_type       : 0x1::string::utf8(b"Generic NFT"),
            nft_id         : 0x1::string::utf8(b"0x"),
            winner_address : 0x1::option::none<address>(),
            prize_claimed  : false,
            ticket_holders : 0x1::vector::empty<address>(),
        };
        0x2::dynamic_object_field::add<vector<u8>, T0>(&mut v2.id, b"nft", arg0);
        let v3 = RaffleCreated{
            raffle_id    : 0x2::object::id<Raffle>(&v2),
            creator      : v0,
            nft_held_id  : v2.nft_id,
            ticket_price : arg3,
            max_tickets  : arg4,
            end_time     : v1,
        };
        0x2::event::emit<RaffleCreated>(v3);
        0x2::transfer::share_object<Raffle>(v2);
    }

    public entry fun draw_winner(arg0: &GlobalConfig, arg1: &mut Raffle, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.is_initialized, 4);
        assert!(is_admin(arg0, 0x2::tx_context::sender(arg4)), 4);
        validate_winner_selection_status(arg1, 0x2::clock::timestamp_ms(arg3));
        let v0 = *0x1::vector::borrow<address>(&arg1.ticket_holders, generate_random_winner(arg2, arg1.tickets_sold, 0x2::clock::timestamp_ms(arg3)));
        arg1.active = false;
        arg1.winner_address = 0x1::option::some<address>(v0);
        let v1 = RaffleEnded{
            raffle_id : 0x2::object::id<Raffle>(arg1),
            winner    : v0,
            nft_id    : arg1.nft_id,
        };
        0x2::event::emit<RaffleEnded>(v1);
    }

    fun generate_random_winner(arg0: vector<u8>, arg1: u64, arg2: u64) : u64 {
        if (arg1 == 0) {
            return 0
        };
        let v0 = 0x1::vector::length<u8>(&arg0);
        let v1 = if (v0 > 2) {
            arg2 % 1000000 + (*0x1::vector::borrow<u8>(&arg0, 0) as u64) + (*0x1::vector::borrow<u8>(&arg0, 1) as u64) * 17 + (*0x1::vector::borrow<u8>(&arg0, 2) as u64) * 31 + arg1 * 7919
        } else if (v0 > 1) {
            arg2 % 1000000 + (*0x1::vector::borrow<u8>(&arg0, 0) as u64) + (*0x1::vector::borrow<u8>(&arg0, 1) as u64) * 17 + arg1 * 7919
        } else if (v0 > 0) {
            arg2 % 1000000 + (*0x1::vector::borrow<u8>(&arg0, 0) as u64) + arg1 * 7919
        } else {
            arg2 % 1000000 + arg1 * 7919
        };
        v1 % arg1
    }

    public fun get_raffle_info(arg0: &Raffle, arg1: &0x2::clock::Clock) : (0x1::string::String, 0x1::string::String, address, u64, u64, u64, u64, bool, 0x1::string::String, u64, bool, bool) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        (arg0.name, arg0.description, arg0.creator, arg0.ticket_price, arg0.max_tickets, arg0.tickets_sold, arg0.end_time, arg0.active, arg0.nft_id, get_raffle_status(arg0, v0), 0x1::option::is_some<address>(&arg0.winner_address), v0 >= arg0.end_time)
    }

    fun get_raffle_status(arg0: &Raffle, arg1: u64) : u64 {
        if (!arg0.active && 0x1::option::is_some<address>(&arg0.winner_address)) {
            if (arg0.prize_claimed) {
                return 4
            };
            return 3
        };
        if (arg0.tickets_sold >= arg0.max_tickets) {
            return 2
        };
        if (arg1 >= arg0.end_time) {
            return 2
        };
        if (arg0.active) {
            return 1
        };
        0
    }

    public fun get_status(arg0: &Raffle, arg1: &0x2::clock::Clock) : u64 {
        get_raffle_status(arg0, 0x2::clock::timestamp_ms(arg1))
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v1, v0);
        let v2 = GlobalConfig{
            id              : 0x2::object::new(arg0),
            fee_percentage  : 500,
            fee_address     : v0,
            admin_addresses : v1,
            is_initialized  : true,
        };
        0x2::transfer::share_object<GlobalConfig>(v2);
    }

    fun is_admin(arg0: &GlobalConfig, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.admin_addresses, &arg1)
    }

    public entry fun remove_admin(arg0: &mut GlobalConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.is_initialized, 4);
        assert!(is_admin(arg0, 0x2::tx_context::sender(arg2)), 4);
        assert!(0x1::vector::length<address>(&arg0.admin_addresses) > 1, 3);
        if (0x1::vector::length<address>(&arg0.admin_addresses) == 1) {
            assert!(arg1 != 0x2::tx_context::sender(arg2), 4);
        };
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.admin_addresses, &arg1);
        assert!(v0, 4);
        0x1::vector::remove<address>(&mut arg0.admin_addresses, v1);
    }

    public entry fun update_fee_address(arg0: &mut GlobalConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.is_initialized, 4);
        assert!(is_admin(arg0, 0x2::tx_context::sender(arg2)), 4);
        assert!(arg1 != @0x0, 1);
        arg0.fee_address = arg1;
    }

    public entry fun update_fee_percentage(arg0: &mut GlobalConfig, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.is_initialized, 4);
        assert!(is_admin(arg0, 0x2::tx_context::sender(arg2)), 4);
        assert!(arg1 <= 1000, 1);
        arg0.fee_percentage = arg1;
    }

    fun validate_prize_claim_status(arg0: &Raffle, arg1: address) {
        assert!(!arg0.active, 15);
        assert!(0x1::option::is_some<address>(&arg0.winner_address), 20);
        assert!(*0x1::option::borrow<address>(&arg0.winner_address) == arg1, 4);
        assert!(!arg0.prize_claimed, 17);
    }

    fun validate_ticket_purchase_status(arg0: &Raffle, arg1: u64) {
        assert!(arg0.active, 2);
        assert!(arg1 < arg0.end_time, 6);
        assert!(arg0.tickets_sold < arg0.max_tickets, 19);
        assert!(0x1::option::is_none<address>(&arg0.winner_address), 20);
    }

    fun validate_winner_selection_status(arg0: &Raffle, arg1: u64) {
        assert!(arg0.active, 2);
        assert!(arg0.tickets_sold > 0, 3);
        assert!(arg1 >= arg0.end_time || arg0.tickets_sold >= arg0.max_tickets, 15);
        assert!(0x1::option::is_none<address>(&arg0.winner_address), 20);
    }

    public entry fun withdraw_nft<T0: store + key>(arg0: &GlobalConfig, arg1: &mut Raffle, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.is_initialized, 4);
        assert!(is_admin(arg0, 0x2::tx_context::sender(arg3)), 4);
        assert!(!arg1.active, 15);
        assert!(arg1.tickets_sold == 0, 1);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg1.end_time, 15);
        if (0x2::dynamic_object_field::exists_<vector<u8>>(&arg1.id, b"nft")) {
            0x2::transfer::public_transfer<T0>(0x2::dynamic_object_field::remove<vector<u8>, T0>(&mut arg1.id, b"nft"), arg1.creator);
        };
    }

    // decompiled from Move bytecode v6
}

