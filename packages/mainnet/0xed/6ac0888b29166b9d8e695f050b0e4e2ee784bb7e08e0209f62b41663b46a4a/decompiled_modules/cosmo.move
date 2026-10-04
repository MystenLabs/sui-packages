module 0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::cosmo {
    struct TicketFilledEvent has copy, drop {
        ticket_id: u64,
        campaign_id: u64,
        numbers: vector<u8>,
    }

    struct TicketsRenewedEvent has copy, drop {
        campaign_id: u64,
        count: u64,
        fee_paid: u64,
    }

    struct PrizeFundDepositedEvent has copy, drop {
        amount: u64,
    }

    struct WinnersDrawnEvent has copy, drop {
        campaign_id: u64,
        grand_prize_mask: 0x1::option::Option<u64>,
        consol_prize_masks: vector<u64>,
        grand_winners_count: u64,
        consol_winners_count: u64,
        total_amount: u64,
        remaining_amount: u64,
    }

    struct CosmoTicket has store, key {
        id: 0x2::object::UID,
        ticket_id: u64,
        campaign_id: u64,
        numbers: 0x1::option::Option<vector<u8>>,
        image_url: 0x1::string::String,
    }

    struct Campaign has store {
        id: u64,
        is_active: bool,
        grand_winners_count: u64,
        consol_winners_count: u64,
        total_tickets: u64,
        ticket_counts: 0x2::table::Table<u64, u64>,
        total_amount: u64,
        remaining_amount: u64,
        start_claim: u64,
        end_claim: u64,
        draw_time: u64,
        grand_prize_mask: 0x1::option::Option<u64>,
        consol_prize_masks: vector<u64>,
    }

    struct CosmoPool has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        receiver: address,
        current_campaign_id: u64,
        campaigns: 0x2::table::Table<u64, Campaign>,
        total_profit: u64,
        is_final_campaign: bool,
        renew_fee: u64,
        next_ticket_id: u64,
    }

    struct COSMO has drop {
        dummy_field: bool,
    }

    struct CampaignView has copy, drop {
        id: u64,
        is_active: bool,
        grand_winners_count: u64,
        consol_winners_count: u64,
        total_tickets: u64,
        total_amount: u64,
        remaining_amount: u64,
        start_claim: u64,
        end_claim: u64,
        draw_time: u64,
        grand_prize_mask: 0x1::option::Option<u64>,
        consol_prize_masks: vector<u64>,
    }

    public fun claim_reward(arg0: &0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::config::AppConfig, arg1: &mut CosmoPool, arg2: CosmoTicket, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::config::check_version(arg0);
        let CosmoTicket {
            id          : v0,
            ticket_id   : _,
            campaign_id : v2,
            numbers     : v3,
            image_url   : _,
        } = arg2;
        let v5 = v3;
        0x2::object::delete(v0);
        assert!(0x1::option::is_some<vector<u8>>(&v5), 206);
        let v6 = encode_numbers(0x1::option::destroy_some<vector<u8>>(v5));
        let v7 = 0x2::table::borrow_mut<u64, Campaign>(&mut arg1.campaigns, v2);
        assert!(!v7.is_active, 203);
        let v8 = 0x2::clock::timestamp_ms(arg3);
        assert!(v8 <= v7.end_claim, 202);
        assert!(v8 >= v7.start_claim, 207);
        let v9 = 0x1::option::is_some<u64>(&v7.grand_prize_mask) && 0x1::option::borrow<u64>(&v7.grand_prize_mask) == &v6;
        let v10 = false;
        let v11 = 0;
        while (v11 < 0x1::vector::length<u64>(&v7.consol_prize_masks)) {
            if (0x1::vector::borrow<u64>(&v7.consol_prize_masks, v11) == &v6) {
                v10 = true;
                break
            };
            v11 = v11 + 1;
        };
        assert!(v9 || v10, 206);
        let v12 = 0;
        if (v9 && v7.grand_winners_count > 0) {
            v12 = v7.total_amount * 80 / 100 / v7.grand_winners_count;
        } else if (v10 && v7.consol_winners_count > 0) {
            v12 = v7.total_amount * 20 / 100 / v7.consol_winners_count;
        };
        assert!(v7.remaining_amount >= v12, 201);
        v7.remaining_amount = v7.remaining_amount - v12;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.balance, v12, arg4), 0x2::tx_context::sender(arg4));
    }

    fun construct_filled_svg(arg0: vector<u8>, arg1: u64, arg2: u64) : 0x1::string::String {
        let v0 = 0x1::string::utf8(0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::storage::get_svg_prefix());
        let v1 = 0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::storage::get_ball_x_positions();
        let v2 = 0;
        while (v2 < 6) {
            let v3 = *0x1::vector::borrow<vector<u8>>(&v1, v2);
            0x1::string::append_utf8(&mut v0, 0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::storage::get_circle_prefix());
            0x1::string::append_utf8(&mut v0, v3);
            0x1::string::append_utf8(&mut v0, 0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::storage::get_circle_suffix());
            0x1::string::append_utf8(&mut v0, 0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::storage::get_text_prefix());
            0x1::string::append_utf8(&mut v0, v3);
            0x1::string::append_utf8(&mut v0, 0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::storage::get_text_mid());
            0x1::string::append_utf8(&mut v0, number_to_ascii(*0x1::vector::borrow<u8>(&arg0, v2)));
            0x1::string::append_utf8(&mut v0, 0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::storage::get_text_close());
            v2 = v2 + 1;
        };
        0x1::string::append_utf8(&mut v0, 0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::storage::get_svg_suffix_pre_campaign());
        0x1::string::append_utf8(&mut v0, u64_to_ascii(arg1));
        0x1::string::append_utf8(&mut v0, b"%20-%20Ticket%20%23");
        0x1::string::append_utf8(&mut v0, u64_to_ascii(arg2));
        0x1::string::append_utf8(&mut v0, 0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::storage::get_svg_suffix_post_campaign());
        v0
    }

    entry fun create_new_campaign(arg0: &0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::config::AppConfig, arg1: &mut CosmoPool, arg2: &mut 0x2::tx_context::TxContext) {
        0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::config::check_admin(arg0, arg2);
        let v0 = arg1.current_campaign_id + 1;
        create_new_campaign_internal(arg1, v0, arg2);
        arg1.current_campaign_id = v0;
    }

    fun create_new_campaign_internal(arg0: &mut CosmoPool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Campaign{
            id                   : arg1,
            is_active            : true,
            grand_winners_count  : 0,
            consol_winners_count : 0,
            total_tickets        : 0,
            ticket_counts        : 0x2::table::new<u64, u64>(arg2),
            total_amount         : 0,
            remaining_amount     : 0,
            start_claim          : 0,
            end_claim            : 0,
            draw_time            : 0,
            grand_prize_mask     : 0x1::option::none<u64>(),
            consol_prize_masks   : vector[],
        };
        0x2::table::add<u64, Campaign>(&mut arg0.campaigns, arg1, v0);
    }

    entry fun deposit_prize_fund(arg0: &0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::config::AppConfig, arg1: &mut CosmoPool, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::config::check_version(arg0);
        0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::config::check_admin(arg0, arg3);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        let v0 = PrizeFundDepositedEvent{amount: 0x2::coin::value<0x2::sui::SUI>(&arg2)};
        0x2::event::emit<PrizeFundDepositedEvent>(v0);
    }

    fun digit_to_byte(arg0: u8) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v0, arg0 + 48);
        v0
    }

    entry fun draw_winners(arg0: &mut CosmoPool, arg1: &0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::config::AppConfig, arg2: u64, arg3: u64, arg4: &0x2::random::Random, arg5: &mut 0x2::tx_context::TxContext) {
        0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::config::check_version(arg1);
        0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::config::check_admin(arg1, arg5);
        let v0 = arg0.current_campaign_id;
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&arg0.balance);
        let v2 = 0;
        let v3 = 0;
        let v4 = 0x2::table::borrow_mut<u64, Campaign>(&mut arg0.campaigns, v0);
        assert!(v4.is_active, 204);
        v4.is_active = false;
        v4.start_claim = arg2;
        v4.end_claim = arg3;
        let v5 = 0x2::random::new_generator(arg4, arg5);
        let v6 = &mut v5;
        let v7 = generate_lucky_mask(v6);
        v4.grand_prize_mask = 0x1::option::some<u64>(v7);
        if (0x2::table::contains<u64, u64>(&v4.ticket_counts, v7)) {
            v2 = *0x2::table::borrow<u64, u64>(&v4.ticket_counts, v7);
        };
        v4.grand_winners_count = v2;
        let v8 = vector[];
        let v9 = 0;
        while (v9 < 3) {
            let v10 = &mut v5;
            let v11 = generate_lucky_mask(v10);
            while (v11 == v7 || 0x1::vector::contains<u64>(&v8, &v11)) {
                let v12 = &mut v5;
                v11 = generate_lucky_mask(v12);
            };
            0x1::vector::push_back<u64>(&mut v8, v11);
            if (0x2::table::contains<u64, u64>(&v4.ticket_counts, v11)) {
                v3 = v3 + *0x2::table::borrow<u64, u64>(&v4.ticket_counts, v11);
            };
            v9 = v9 + 1;
        };
        v4.consol_prize_masks = v8;
        v4.consol_winners_count = v3;
        let v13 = 0;
        let v14 = v13;
        if (v2 > 0) {
            v14 = v13 + v1 * 80 / 100;
        };
        if (v3 > 0) {
            v14 = v14 + v1 * 20 / 100;
        };
        v4.total_amount = v1;
        v4.remaining_amount = v14;
        let v15 = 0x2::table::borrow<u64, Campaign>(&arg0.campaigns, v0);
        let v16 = WinnersDrawnEvent{
            campaign_id          : v0,
            grand_prize_mask     : v15.grand_prize_mask,
            consol_prize_masks   : v15.consol_prize_masks,
            grand_winners_count  : v15.grand_winners_count,
            consol_winners_count : v15.consol_winners_count,
            total_amount         : v15.total_amount,
            remaining_amount     : v15.remaining_amount,
        };
        0x2::event::emit<WinnersDrawnEvent>(v16);
        if (!arg0.is_final_campaign) {
            let v17 = arg0.current_campaign_id + 1;
            create_new_campaign_internal(arg0, v17, arg5);
            arg0.current_campaign_id = v17;
        };
    }

    public fun encode_numbers(arg0: vector<u8>) : u64 {
        assert!(0x1::vector::length<u8>(&arg0) == 6, 208);
        let v0 = 0;
        let v1 = 0;
        while (v1 < 6) {
            let v2 = *0x1::vector::borrow<u8>(&arg0, v1);
            assert!(v2 >= 1 && v2 <= 45, 209);
            let v3 = 1 << v2;
            assert!(v0 & v3 == 0, 210);
            v0 = v0 | v3;
            v1 = v1 + 1;
        };
        v0
    }

    public fun fill_ticket(arg0: &0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::config::AppConfig, arg1: &mut CosmoPool, arg2: &mut CosmoTicket, arg3: vector<u8>, arg4: &0x2::clock::Clock) {
        0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::config::check_version(arg0);
        0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::config::check_cosmo_enabled(arg0);
        assert!(0x1::option::is_none<vector<u8>>(&arg2.numbers), 212);
        let v0 = encode_numbers(arg3);
        let v1 = arg2.campaign_id;
        assert!(v1 == arg1.current_campaign_id, 213);
        let v2 = 0x2::table::borrow_mut<u64, Campaign>(&mut arg1.campaigns, v1);
        assert!(v2.is_active, 204);
        assert!(v2.draw_time == 0 || 0x2::clock::timestamp_ms(arg4) <= v2.draw_time, 214);
        arg2.numbers = 0x1::option::some<vector<u8>>(arg3);
        arg2.image_url = construct_filled_svg(arg3, v1, arg2.ticket_id);
        let v3 = if (0x2::table::contains<u64, u64>(&v2.ticket_counts, v0)) {
            *0x2::table::borrow<u64, u64>(&v2.ticket_counts, v0)
        } else {
            0
        };
        if (v3 == 0) {
            0x2::table::add<u64, u64>(&mut v2.ticket_counts, v0, 1);
        } else {
            *0x2::table::borrow_mut<u64, u64>(&mut v2.ticket_counts, v0) = v3 + 1;
        };
        v2.total_tickets = v2.total_tickets + 1;
        let v4 = TicketFilledEvent{
            ticket_id   : arg2.ticket_id,
            campaign_id : v1,
            numbers     : arg3,
        };
        0x2::event::emit<TicketFilledEvent>(v4);
    }

    public fun fill_tickets(arg0: &0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::config::AppConfig, arg1: &mut CosmoPool, arg2: &mut vector<CosmoTicket>, arg3: vector<vector<u8>>, arg4: &0x2::clock::Clock) {
        0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::config::check_version(arg0);
        0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::config::check_cosmo_enabled(arg0);
        let v0 = 0x1::vector::length<CosmoTicket>(arg2);
        assert!(v0 == 0x1::vector::length<vector<u8>>(&arg3), 208);
        assert!(v0 > 0, 211);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = 0x1::vector::borrow_mut<CosmoTicket>(arg2, v1);
            fill_ticket(arg0, arg1, v2, *0x1::vector::borrow<vector<u8>>(&arg3, v1), arg4);
            v1 = v1 + 1;
        };
    }

    fun generate_lucky_mask(arg0: &mut 0x2::random::RandomGenerator) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 6) {
            let v2 = 1 << 0x2::random::generate_u8_in_range(arg0, 1, 45);
            if (v0 & v2 == 0) {
                v0 = v0 | v2;
                v1 = v1 + 1;
            };
        };
        v0
    }

    public fun get_all_campaigns(arg0: &CosmoPool) : vector<CampaignView> {
        let v0 = 0x1::vector::empty<CampaignView>();
        let v1 = 1;
        while (v1 <= arg0.current_campaign_id) {
            if (0x2::table::contains<u64, Campaign>(&arg0.campaigns, v1)) {
                let v2 = 0x2::table::borrow<u64, Campaign>(&arg0.campaigns, v1);
                let v3 = CampaignView{
                    id                   : v2.id,
                    is_active            : v2.is_active,
                    grand_winners_count  : v2.grand_winners_count,
                    consol_winners_count : v2.consol_winners_count,
                    total_tickets        : v2.total_tickets,
                    total_amount         : v2.total_amount,
                    remaining_amount     : v2.remaining_amount,
                    start_claim          : v2.start_claim,
                    end_claim            : v2.end_claim,
                    draw_time            : v2.draw_time,
                    grand_prize_mask     : v2.grand_prize_mask,
                    consol_prize_masks   : v2.consol_prize_masks,
                };
                0x1::vector::push_back<CampaignView>(&mut v0, v3);
            };
            v1 = v1 + 1;
        };
        v0
    }

    entry fun get_current_campaign_info(arg0: &CosmoPool) : CampaignView {
        let v0 = 0x2::table::borrow<u64, Campaign>(&arg0.campaigns, arg0.current_campaign_id);
        CampaignView{
            id                   : v0.id,
            is_active            : v0.is_active,
            grand_winners_count  : v0.grand_winners_count,
            consol_winners_count : v0.consol_winners_count,
            total_tickets        : v0.total_tickets,
            total_amount         : v0.total_amount,
            remaining_amount     : v0.remaining_amount,
            start_claim          : v0.start_claim,
            end_claim            : v0.end_claim,
            draw_time            : v0.draw_time,
            grand_prize_mask     : v0.grand_prize_mask,
            consol_prize_masks   : v0.consol_prize_masks,
        }
    }

    fun init(arg0: COSMO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = CosmoPool{
            id                  : 0x2::object::new(arg1),
            balance             : 0x2::balance::zero<0x2::sui::SUI>(),
            receiver            : 0x2::tx_context::sender(arg1),
            current_campaign_id : 1,
            campaigns           : 0x2::table::new<u64, Campaign>(arg1),
            total_profit        : 0,
            is_final_campaign   : false,
            renew_fee           : 100000000,
            next_ticket_id      : 1,
        };
        let v2 = &mut v1;
        create_new_campaign_internal(v2, 1, arg1);
        let v3 = 0x2::package::claim<COSMO>(arg0, arg1);
        let v4 = 0x2::display::new<CosmoTicket>(&v3, arg1);
        let v5 = 0x1::vector::empty<0x1::string::String>();
        let v6 = &mut v5;
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"creator"));
        let v7 = 0x1::vector::empty<0x1::string::String>();
        let v8 = &mut v7;
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"Cosmo Ticket #{ticket_id} - Campaign #{campaign_id}"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"A complimentary promotional ticket granted exclusively to active members of The Empty Box Club for hitting ecosystem interaction milestones. Owners can configure a unique 6-number attribute set on this ticket to participate in the decentralized Cosmo Draw campaign, unlocking a direct claim to the fully sponsored Cosmo Treasury."));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"https://theemptyboxclub.com/"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"TEBC Co., LTD"));
        0x2::display::add_multiple<CosmoTicket>(&mut v4, v5, v7);
        0x2::display::update_version<CosmoTicket>(&mut v4);
        let (v9, v10) = 0x2::transfer_policy::new<CosmoTicket>(&v3, arg1);
        let v11 = v10;
        let v12 = v9;
        0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::rules::add_personal_kiosk_rule<CosmoTicket>(&mut v12, &v11);
        0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::rules::add_royalty_rule<CosmoTicket>(&mut v12, &v11, 0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::rules::new_royalty_config(500, 0));
        0x2::transfer::share_object<CosmoPool>(v1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v3, v0);
        0x2::transfer::public_transfer<0x2::display::Display<CosmoTicket>>(v4, v0);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<CosmoTicket>>(v11, v0);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<CosmoTicket>>(v12);
    }

    fun number_to_ascii(arg0: u8) : vector<u8> {
        let v0 = arg0 / 10;
        if (v0 == 0) {
            digit_to_byte(arg0 % 10)
        } else {
            let v2 = digit_to_byte(v0);
            0x1::vector::append<u8>(&mut v2, digit_to_byte(arg0 % 10));
            v2
        }
    }

    public(friend) fun record_profit(arg0: &mut CosmoPool, arg1: u64) {
        arg0.total_profit = arg0.total_profit + arg1;
    }

    public(friend) fun register_ticket(arg0: &mut CosmoPool, arg1: &mut 0x2::tx_context::TxContext) : CosmoTicket {
        let v0 = arg0.current_campaign_id;
        let v1 = arg0.next_ticket_id;
        arg0.next_ticket_id = v1 + 1;
        CosmoTicket{
            id          : 0x2::object::new(arg1),
            ticket_id   : v1,
            campaign_id : v0,
            numbers     : 0x1::option::none<vector<u8>>(),
            image_url   : 0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::storage::get_ticket_base_url(v0, v1),
        }
    }

    public fun renew_tickets(arg0: &0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::config::AppConfig, arg1: &mut CosmoPool, arg2: &mut vector<CosmoTicket>, arg3: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::config::check_version(arg0);
        let v0 = 0x1::vector::length<CosmoTicket>(arg2);
        assert!(v0 > 0, 211);
        let v1 = arg1.renew_fee * v0;
        assert!(0x2::coin::value<0x2::sui::SUI>(arg3) >= v1, 215);
        let v2 = arg1.current_campaign_id;
        let v3 = 0x2::table::borrow_mut<u64, Campaign>(&mut arg1.campaigns, v2);
        assert!(v3.is_active, 204);
        if (v3.draw_time > 0) {
            assert!(0x2::clock::timestamp_ms(arg4) <= v3.draw_time, 214);
        };
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(arg3), v1), arg5), arg1.receiver);
        };
        let v4 = 0;
        while (v4 < v0) {
            let v5 = 0x1::vector::borrow_mut<CosmoTicket>(arg2, v4);
            if (v5.campaign_id == v2) {
                if (0x1::option::is_some<vector<u8>>(&v5.numbers)) {
                    let v6 = encode_numbers(*0x1::option::borrow<vector<u8>>(&v5.numbers));
                    if (0x2::table::contains<u64, u64>(&v3.ticket_counts, v6)) {
                        let v7 = 0x2::table::borrow_mut<u64, u64>(&mut v3.ticket_counts, v6);
                        if (*v7 > 0) {
                            *v7 = *v7 - 1;
                        };
                    };
                    if (v3.total_tickets > 0) {
                        v3.total_tickets = v3.total_tickets - 1;
                    };
                };
            };
            v5.numbers = 0x1::option::none<vector<u8>>();
            v5.campaign_id = v2;
            v5.image_url = 0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::storage::get_ticket_base_url(v2, v5.ticket_id);
            v4 = v4 + 1;
        };
        let v8 = TicketsRenewedEvent{
            campaign_id : v2,
            count       : v0,
            fee_paid    : v1,
        };
        0x2::event::emit<TicketsRenewedEvent>(v8);
    }

    entry fun set_draw_time(arg0: &0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::config::AppConfig, arg1: &mut CosmoPool, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::config::check_admin(arg0, arg3);
        let v0 = 0x2::table::borrow_mut<u64, Campaign>(&mut arg1.campaigns, arg1.current_campaign_id);
        assert!(v0.is_active, 204);
        v0.draw_time = arg2;
    }

    entry fun set_final_campaign(arg0: &0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::config::AppConfig, arg1: &mut CosmoPool, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::config::check_admin(arg0, arg3);
        arg1.is_final_campaign = arg2;
    }

    entry fun set_receiver(arg0: &0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::config::AppConfig, arg1: &mut CosmoPool, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::config::check_admin(arg0, arg3);
        arg1.receiver = arg2;
    }

    entry fun set_renew_fee(arg0: &0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::config::AppConfig, arg1: &mut CosmoPool, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::config::check_admin(arg0, arg3);
        arg1.renew_fee = arg2;
    }

    fun u64_to_ascii(arg0: u64) : vector<u8> {
        if (arg0 == 0) {
            return b"0"
        };
        let v0 = b"";
        while (arg0 > 0) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 % 10) as u8) + 48);
            arg0 = arg0 / 10;
        };
        let v1 = b"";
        let v2 = 0x1::vector::length<u8>(&v0);
        while (v2 > 0) {
            v2 = v2 - 1;
            0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(&v0, v2));
        };
        v1
    }

    public fun update_display(arg0: &0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::config::AppConfig, arg1: &mut 0x2::display::Display<CosmoTicket>, arg2: vector<0x1::string::String>, arg3: vector<0x1::string::String>, arg4: &mut 0x2::tx_context::TxContext) {
        0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::config::check_version(arg0);
        0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::config::check_admin(arg0, arg4);
        let v0 = 0x1::vector::length<0x1::string::String>(&arg2);
        assert!(v0 == 0x1::vector::length<0x1::string::String>(&arg3), 216);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = *0x1::vector::borrow<0x1::string::String>(&arg2, v1);
            if (0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(0x2::display::fields<CosmoTicket>(arg1), &v2)) {
                0x2::display::edit<CosmoTicket>(arg1, v2, *0x1::vector::borrow<0x1::string::String>(&arg3, v1));
            } else {
                0x2::display::add<CosmoTicket>(arg1, v2, *0x1::vector::borrow<0x1::string::String>(&arg3, v1));
            };
            v1 = v1 + 1;
        };
        0x2::display::update_version<CosmoTicket>(arg1);
    }

    public fun withdraw_remaining_funds(arg0: &0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::config::AppConfig, arg1: &mut CosmoPool, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::config::check_version(arg0);
        0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::config::check_admin(arg0, arg4);
        assert!(0x2::table::contains<u64, Campaign>(&arg1.campaigns, arg2), 205);
        let v0 = 0x2::table::borrow_mut<u64, Campaign>(&mut arg1.campaigns, arg2);
        assert!(v0.is_active == false, 203);
        assert!(0x2::clock::timestamp_ms(arg3) > v0.end_claim, 203);
        v0.remaining_amount = 0;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.balance, v0.remaining_amount, arg4), arg1.receiver);
    }

    // decompiled from Move bytecode v7
}

