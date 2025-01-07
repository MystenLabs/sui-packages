module 0x4f0a1581686af92746f3313511e12f82543eaf2c6ca152fa1e77765dc38f9309::auction {
    struct AUCTION has drop {
        dummy_field: bool,
    }

    struct Auction<phantom T0> has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        item_addrs: vector<address>,
        item_bag: 0x2::object_bag::ObjectBag,
        admin_addr: address,
        pay_addr: address,
        lead_addr: address,
        lead_bal: 0x2::balance::Balance<T0>,
        begin_time_ms: u64,
        end_time_ms: u64,
        minimum_bid: u64,
        minimum_increase_bps: u64,
        extension_period_ms: u64,
    }

    public fun admin_accepts_bid<T0>(arg0: &mut Auction<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin_addr == 0x2::tx_context::sender(arg2), 5002);
        assert!(is_live<T0>(arg0, arg1), 5001);
        assert!(has_leader<T0>(arg0), 5017);
        arg0.end_time_ms = 0x2::clock::timestamp_ms(arg1);
    }

    public fun admin_addr<T0>(arg0: &Auction<T0>) : address {
        arg0.admin_addr
    }

    public fun admin_cancels_auction<T0>(arg0: &mut Auction<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin_addr == 0x2::tx_context::sender(arg2), 5002);
        assert!(!has_ended<T0>(arg0, arg1), 5001);
        arg0.end_time_ms = 0x2::clock::timestamp_ms(arg1);
        if (has_balance<T0>(arg0)) {
            let v0 = arg0.lead_addr;
            withdraw_balance<T0>(arg0, v0, arg2);
            arg0.lead_addr = @0x0;
        };
    }

    public fun admin_creates_auction<T0>(arg0: 0x4f0a1581686af92746f3313511e12f82543eaf2c6ca152fa1e77765dc38f9309::user::UserRequest, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<address>, arg4: 0x2::object_bag::ObjectBag, arg5: address, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : (0x4f0a1581686af92746f3313511e12f82543eaf2c6ca152fa1e77765dc38f9309::user::UserRequest, Auction<T0>) {
        assert!(0x1::vector::length<u8>(&arg1) >= 3, 5000);
        assert!(0x1::vector::length<u8>(&arg1) <= 100, 5000);
        assert!(0x1::vector::length<u8>(&arg2) >= 0, 5006);
        assert!(0x1::vector::length<u8>(&arg2) <= 2000, 5006);
        assert!(arg5 != @0x0, 5003);
        let v0 = 0x2::clock::timestamp_ms(arg11);
        let v1 = v0 + arg6;
        assert!(v1 <= v0 + 8640000000, 5001);
        assert!(arg7 >= 10000, 5004);
        assert!(arg7 <= 8640000000, 5004);
        assert!(arg8 > 0, 5007);
        assert!(arg9 >= 10, 5008);
        assert!(arg9 <= 100000, 5008);
        assert!(arg10 >= 1000, 5009);
        assert!(arg10 <= 864000000, 5009);
        assert!(arg10 <= arg7, 5009);
        assert!(0x1::vector::length<address>(&arg3) > 0, 5014);
        assert!(0x1::vector::length<address>(&arg3) <= 50, 5015);
        assert!(0x1::vector::length<address>(&arg3) == 0x2::object_bag::length(&arg4), 5013);
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(&arg3)) {
            assert!(0x2::object_bag::contains<address>(&arg4, *0x1::vector::borrow<address>(&arg3, v2)), 5016);
            let v3 = v2 + 1;
            while (v3 < 0x1::vector::length<address>(&arg3)) {
                assert!(*0x1::vector::borrow<address>(&arg3, v3) != *0x1::vector::borrow<address>(&arg3, v2), 5012);
                v3 = v3 + 1;
            };
            v2 = v2 + 1;
        };
        let v4 = Auction<T0>{
            id                   : 0x2::object::new(arg12),
            name                 : 0x1::string::utf8(arg1),
            description          : 0x1::string::utf8(arg2),
            item_addrs           : arg3,
            item_bag             : arg4,
            admin_addr           : 0x2::tx_context::sender(arg12),
            pay_addr             : arg5,
            lead_addr            : @0x0,
            lead_bal             : 0x2::balance::zero<T0>(),
            begin_time_ms        : v1,
            end_time_ms          : v1 + arg7,
            minimum_bid          : arg8,
            minimum_increase_bps : arg9,
            extension_period_ms  : arg10,
        };
        0x4f0a1581686af92746f3313511e12f82543eaf2c6ca152fa1e77765dc38f9309::user::add_created(&mut arg0, 0x2::object::uid_to_address(&v4.id), 0x2::clock::timestamp_ms(arg11));
        (arg0, v4)
    }

    public fun admin_reclaims_item<T0, T1: store + key>(arg0: &mut Auction<T0>, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin_addr == 0x2::tx_context::sender(arg3), 5002);
        assert!(has_ended<T0>(arg0, arg2), 5001);
        assert!(!has_leader<T0>(arg0), 5010);
        if (0x2::object_bag::contains<address>(&arg0.item_bag, arg1)) {
            0x2::transfer::public_transfer<T1>(0x2::object_bag::remove<address, T1>(&mut arg0.item_bag, arg1), arg0.admin_addr);
        };
    }

    public fun admin_sets_pay_addr<T0>(arg0: &mut Auction<T0>, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin_addr == 0x2::tx_context::sender(arg3), 5002);
        assert!(arg1 != @0x0, 5003);
        assert!(!has_ended<T0>(arg0, arg2) || has_balance<T0>(arg0), 5011);
        arg0.pay_addr = arg1;
    }

    public fun anyone_bids<T0>(arg0: &mut Auction<T0>, arg1: 0x4f0a1581686af92746f3313511e12f82543eaf2c6ca152fa1e77765dc38f9309::user::UserRequest, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x4f0a1581686af92746f3313511e12f82543eaf2c6ca152fa1e77765dc38f9309::user::UserRequest {
        assert!(is_live<T0>(arg0, arg3), 5001);
        assert!(0x2::coin::value<T0>(&arg2) >= arg0.minimum_bid, 5005);
        if (has_balance<T0>(arg0)) {
            let v0 = arg0.lead_addr;
            withdraw_balance<T0>(arg0, v0, arg4);
        };
        arg0.lead_addr = 0x2::tx_context::sender(arg4);
        0x2::balance::join<T0>(&mut arg0.lead_bal, 0x2::coin::into_balance<T0>(arg2));
        let v1 = (((lead_value<T0>(arg0) as u256) * (10000 + (arg0.minimum_increase_bps as u256)) / 10000) as u64);
        let v2 = v1;
        if (v1 == arg0.minimum_bid) {
            v2 = v1 + 1;
        };
        arg0.minimum_bid = v2;
        let v3 = 0x2::clock::timestamp_ms(arg3);
        if (v3 >= arg0.end_time_ms - arg0.extension_period_ms) {
            arg0.end_time_ms = arg0.end_time_ms + arg0.extension_period_ms;
        };
        0x4f0a1581686af92746f3313511e12f82543eaf2c6ca152fa1e77765dc38f9309::user::add_bid(&mut arg1, 0x2::object::uid_to_address(&arg0.id), v3, lead_value<T0>(arg0));
        arg1
    }

    public fun anyone_pays_funds<T0>(arg0: &mut Auction<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(has_ended<T0>(arg0, arg1), 5001);
        if (has_balance<T0>(arg0)) {
            let v0 = arg0.pay_addr;
            withdraw_balance<T0>(arg0, v0, arg2);
        };
    }

    public fun anyone_sends_item_to_winner<T0, T1: store + key>(arg0: &mut Auction<T0>, arg1: address, arg2: &0x2::clock::Clock) {
        assert!(has_ended<T0>(arg0, arg2), 5001);
        assert!(has_leader<T0>(arg0), 5003);
        if (0x2::object_bag::contains<address>(&arg0.item_bag, arg1)) {
            0x2::transfer::public_transfer<T1>(0x2::object_bag::remove<address, T1>(&mut arg0.item_bag, arg1), arg0.lead_addr);
        };
    }

    public fun begin_time_ms<T0>(arg0: &Auction<T0>) : u64 {
        arg0.begin_time_ms
    }

    public fun description<T0>(arg0: &Auction<T0>) : 0x1::string::String {
        arg0.description
    }

    public fun end_time_ms<T0>(arg0: &Auction<T0>) : u64 {
        arg0.end_time_ms
    }

    public fun extension_period_ms<T0>(arg0: &Auction<T0>) : u64 {
        arg0.extension_period_ms
    }

    public fun has_balance<T0>(arg0: &Auction<T0>) : bool {
        lead_value<T0>(arg0) > 0
    }

    public fun has_ended<T0>(arg0: &Auction<T0>, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) >= arg0.end_time_ms
    }

    public fun has_leader<T0>(arg0: &Auction<T0>) : bool {
        arg0.lead_addr != @0x0
    }

    public fun has_started<T0>(arg0: &Auction<T0>, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) >= arg0.begin_time_ms
    }

    fun init(arg0: AUCTION, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<AUCTION>(arg0, arg1);
        let v1 = 0x2::display::new<Auction<0x2::sui::SUI>>(&v0, arg1);
        0x2::display::add<Auction<0x2::sui::SUI>>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"Auction: {name}"));
        0x2::display::add<Auction<0x2::sui::SUI>>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<Auction<0x2::sui::SUI>>(&mut v1, 0x1::string::utf8(b"link"), 0x1::string::utf8(b"https://bidder.polymedia.app/auction/{id}/items"));
        0x2::display::add<Auction<0x2::sui::SUI>>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"data:image/svg+xml,%3Csvg%20width%3D%22100%25%22%20height%3D%22100%25%22%20viewBox%3D%220%200%20100%20100%22%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%3E%3Crect%20width%3D%22100%22%20height%3D%22100%22%20fill%3D%22%230F4C75%22%2F%3E%3Ctext%20x%3D%2250%22%20y%3D%2250%22%20font-family%3D%22system-ui%2Csans-serif%22%20font-size%3D%2217%22%20font-weight%3D%22bold%22%20fill%3D%22%23fff%22%20text-anchor%3D%22middle%22%20dominant-baseline%3D%22middle%22%3E%3Ctspan%20x%3D%2250%22%20dy%3D%220%22%3EAUCTION%3C%2Ftspan%3E%3C%2Ftext%3E%3Ctext%20x%3D%2294%22%20y%3D%2294%22%20font-family%3D%22system-ui%2Csans-serif%22%20font-size%3D%227%22%20font-weight%3D%22bold%22%20text-anchor%3D%22end%22%20dominant-baseline%3D%22text-bottom%22%3E%3Ctspan%20fill%3D%22yellow%22%20stroke%3D%22black%22%20stroke-width%3D%220.7%22%20paint-order%3D%22stroke%22%3EBIDDER%3C%2Ftspan%3E%3C%2Ftext%3E%3C%2Fsvg%3E"));
        0x2::display::add<Auction<0x2::sui::SUI>>(&mut v1, 0x1::string::utf8(b"project_name"), 0x1::string::utf8(b"BIDDER | Polymedia"));
        0x2::display::add<Auction<0x2::sui::SUI>>(&mut v1, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://bidder.polymedia.app"));
        0x2::display::update_version<Auction<0x2::sui::SUI>>(&mut v1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Auction<0x2::sui::SUI>>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun is_cancelled<T0>(arg0: &Auction<T0>, arg1: &0x2::clock::Clock) : bool {
        has_ended<T0>(arg0, arg1) && !has_leader<T0>(arg0)
    }

    public fun is_live<T0>(arg0: &Auction<T0>, arg1: &0x2::clock::Clock) : bool {
        has_started<T0>(arg0, arg1) && !has_ended<T0>(arg0, arg1)
    }

    public fun item_addrs<T0>(arg0: &Auction<T0>) : &vector<address> {
        &arg0.item_addrs
    }

    public fun item_bag<T0>(arg0: &Auction<T0>) : &0x2::object_bag::ObjectBag {
        &arg0.item_bag
    }

    public fun lead_addr<T0>(arg0: &Auction<T0>) : address {
        arg0.lead_addr
    }

    public fun lead_value<T0>(arg0: &Auction<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.lead_bal)
    }

    public fun max_begin_delay_ms() : u64 {
        8640000000
    }

    public fun max_description_length() : u64 {
        2000
    }

    public fun max_duration_ms() : u64 {
        8640000000
    }

    public fun max_extension_period_ms() : u64 {
        864000000
    }

    public fun max_items() : u64 {
        50
    }

    public fun max_minimum_increase_bps() : u64 {
        100000
    }

    public fun max_name_length() : u64 {
        100
    }

    public fun min_description_length() : u64 {
        0
    }

    public fun min_duration_ms() : u64 {
        10000
    }

    public fun min_extension_period_ms() : u64 {
        1000
    }

    public fun min_minimum_increase_bps() : u64 {
        10
    }

    public fun min_name_length() : u64 {
        3
    }

    public fun minimum_bid<T0>(arg0: &Auction<T0>) : u64 {
        arg0.minimum_bid
    }

    public fun minimum_increase_bps<T0>(arg0: &Auction<T0>) : u64 {
        arg0.minimum_increase_bps
    }

    public fun name<T0>(arg0: &Auction<T0>) : 0x1::string::String {
        arg0.name
    }

    public fun pay_addr<T0>(arg0: &Auction<T0>) : address {
        arg0.pay_addr
    }

    fun withdraw_balance<T0>(arg0: &mut Auction<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.lead_bal), arg2), arg1);
    }

    // decompiled from Move bytecode v6
}

