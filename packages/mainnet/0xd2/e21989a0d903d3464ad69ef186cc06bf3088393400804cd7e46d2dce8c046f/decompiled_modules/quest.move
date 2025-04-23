module 0x26dbda3f935362da3b6ad85abce3bc90b95507c156cc7d8a9c17f441ecfcb605::quest {
    struct QUEST has drop {
        dummy_field: bool,
    }

    struct AirdropRegistry has key {
        id: 0x2::object::UID,
    }

    struct DropConfig has store {
        whitelisted_address: vector<address>,
        status: bool,
        airdrop_value: u8,
    }

    struct QuestRegistry has key {
        id: 0x2::object::UID,
        admin_treasury: address,
        players: 0x2::table::Table<address, u64>,
        bundle_price: 0x2::vec_map::VecMap<u8, u64>,
        status: bool,
        gambit_earn_points: u64,
        max_quest_point: u64,
        current_quest_point: u64,
    }

    struct QuestTicket has key {
        id: 0x2::object::UID,
        count: u8,
    }

    struct CreateDropEvent has copy, drop {
        airdrop_name: 0x1::string::String,
        sender: address,
        timestamp: u64,
        airdrop_value: u8,
    }

    struct UpdateDropEvent has copy, drop {
        airdrop_name: 0x1::string::String,
        sender: address,
        timestamp: u64,
        airdrop_value: u8,
    }

    struct UpdateWhiteListAddressEvent has copy, drop {
        airdrop_name: 0x1::string::String,
        sender: address,
        timestamp: u64,
    }

    struct ChangeQuestStatusEvent has copy, drop {
        sender: address,
        status: bool,
    }

    struct ChangeAirdropStatusEvent has copy, drop {
        airdrop_name: 0x1::string::String,
        sender: address,
        status: bool,
    }

    struct UpdateAdminTreasuryEvent has copy, drop {
        sender: address,
        treasury: address,
    }

    struct UpdateGambitEarnPointEvent has copy, drop {
        sender: address,
        gambit_earn_points: u64,
    }

    struct BuyNewTicketEvent has copy, drop {
        sender: address,
        sui_paid: u64,
        bundle_type: u8,
    }

    struct AddTicketCountEvent has copy, drop {
        sender: address,
        sui_paid: u64,
        bundle_type: u8,
    }

    struct ClaimAirdropExistingEvent has copy, drop {
        sender: address,
        ticket_id: 0x2::object::ID,
        airdrop_type: 0x1::string::String,
        timestamp_ms: u64,
    }

    struct ClaimAirdropNewEvent has copy, drop {
        sender: address,
        airdrop_type: 0x1::string::String,
        timestamp_ms: u64,
    }

    struct TicketConsumedEvent has copy, drop {
        sender: address,
        message: 0x1::string::String,
    }

    public fun add_bundle_price(arg0: &0x26dbda3f935362da3b6ad85abce3bc90b95507c156cc7d8a9c17f441ecfcb605::authority::OperatorCap, arg1: &0x26dbda3f935362da3b6ad85abce3bc90b95507c156cc7d8a9c17f441ecfcb605::authority::OperatorCapsBag, arg2: &0x26dbda3f935362da3b6ad85abce3bc90b95507c156cc7d8a9c17f441ecfcb605::version::Version, arg3: &mut QuestRegistry, arg4: u8, arg5: u64, arg6: &0x2::tx_context::TxContext) {
        0x26dbda3f935362da3b6ad85abce3bc90b95507c156cc7d8a9c17f441ecfcb605::version::validate_version(arg2, 2);
        0x26dbda3f935362da3b6ad85abce3bc90b95507c156cc7d8a9c17f441ecfcb605::authority::is_valid_operator(arg0, 0x2::tx_context::sender(arg6), arg1);
        if (0x2::vec_map::contains<u8, u64>(&arg3.bundle_price, &arg4)) {
            *0x2::vec_map::get_mut<u8, u64>(&mut arg3.bundle_price, &arg4) = arg5;
        } else {
            0x2::vec_map::insert<u8, u64>(&mut arg3.bundle_price, arg4, arg5);
        };
    }

    public(friend) fun add_current_quest_point(arg0: &mut QuestRegistry, arg1: u64) {
        let v0 = arg0.current_quest_point + arg1;
        assert!(v0 <= arg0.max_quest_point, 8);
        arg0.current_quest_point = v0;
    }

    public fun add_ticket_count(arg0: &mut QuestRegistry, arg1: &0x26dbda3f935362da3b6ad85abce3bc90b95507c156cc7d8a9c17f441ecfcb605::version::Version, arg2: &mut QuestTicket, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: u8, arg5: &0x2::tx_context::TxContext) {
        0x26dbda3f935362da3b6ad85abce3bc90b95507c156cc7d8a9c17f441ecfcb605::version::validate_version(arg1, 2);
        assert!(0x2::table::contains<address, u64>(&arg0.players, 0x2::tx_context::sender(arg5)), 4);
        assert!(0x2::vec_map::contains<u8, u64>(&arg0.bundle_price, &arg4), 1);
        assert!(arg0.max_quest_point > arg0.current_quest_point, 7);
        validate_quest_status(arg0);
        let v0 = 0x2::table::borrow_mut<address, u64>(&mut arg0.players, 0x2::tx_context::sender(arg5));
        *v0 = *v0 + (arg4 as u64);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg3);
        assert!(*0x2::vec_map::get<u8, u64>(&arg0.bundle_price, &arg4) == v1, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, arg0.admin_treasury);
        arg2.count = arg2.count + (arg4 as u8);
        let v2 = AddTicketCountEvent{
            sender      : 0x2::tx_context::sender(arg5),
            sui_paid    : v1,
            bundle_type : arg4,
        };
        0x2::event::emit<AddTicketCountEvent>(v2);
    }

    public fun buy_new_ticket(arg0: &mut QuestRegistry, arg1: &0x26dbda3f935362da3b6ad85abce3bc90b95507c156cc7d8a9c17f441ecfcb605::version::Version, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        0x26dbda3f935362da3b6ad85abce3bc90b95507c156cc7d8a9c17f441ecfcb605::version::validate_version(arg1, 2);
        assert!(0x2::vec_map::contains<u8, u64>(&arg0.bundle_price, &arg3), 1);
        validate_quest_status(arg0);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(arg0.max_quest_point > arg0.current_quest_point, 7);
        assert!(*0x2::vec_map::get<u8, u64>(&arg0.bundle_price, &arg3) == v0, 0);
        assert!(!0x2::table::contains<address, u64>(&arg0.players, 0x2::tx_context::sender(arg4)), 3);
        0x2::table::add<address, u64>(&mut arg0.players, 0x2::tx_context::sender(arg4), (arg3 as u64));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, arg0.admin_treasury);
        let v1 = new_ticket(arg3, arg4);
        0x2::transfer::transfer<QuestTicket>(v1, 0x2::tx_context::sender(arg4));
        let v2 = BuyNewTicketEvent{
            sender      : 0x2::tx_context::sender(arg4),
            sui_paid    : v0,
            bundle_type : arg3,
        };
        0x2::event::emit<BuyNewTicketEvent>(v2);
    }

    public fun change_airdrop_status(arg0: &0x26dbda3f935362da3b6ad85abce3bc90b95507c156cc7d8a9c17f441ecfcb605::authority::OperatorCap, arg1: &0x26dbda3f935362da3b6ad85abce3bc90b95507c156cc7d8a9c17f441ecfcb605::authority::OperatorCapsBag, arg2: &0x26dbda3f935362da3b6ad85abce3bc90b95507c156cc7d8a9c17f441ecfcb605::version::Version, arg3: &mut AirdropRegistry, arg4: 0x1::string::String, arg5: bool, arg6: &0x2::tx_context::TxContext) {
        0x26dbda3f935362da3b6ad85abce3bc90b95507c156cc7d8a9c17f441ecfcb605::authority::is_valid_operator(arg0, 0x2::tx_context::sender(arg6), arg1);
        0x26dbda3f935362da3b6ad85abce3bc90b95507c156cc7d8a9c17f441ecfcb605::version::validate_version(arg2, 2);
        assert!(0x2::dynamic_field::exists_<0x1::string::String>(&arg3.id, arg4), 9);
        0x2::dynamic_field::borrow_mut<0x1::string::String, DropConfig>(&mut arg3.id, arg4).status = arg5;
        let v0 = ChangeAirdropStatusEvent{
            airdrop_name : arg4,
            sender       : 0x2::tx_context::sender(arg6),
            status       : arg5,
        };
        0x2::event::emit<ChangeAirdropStatusEvent>(v0);
    }

    public fun change_quest_status(arg0: &0x26dbda3f935362da3b6ad85abce3bc90b95507c156cc7d8a9c17f441ecfcb605::authority::OperatorCap, arg1: &0x26dbda3f935362da3b6ad85abce3bc90b95507c156cc7d8a9c17f441ecfcb605::authority::OperatorCapsBag, arg2: &0x26dbda3f935362da3b6ad85abce3bc90b95507c156cc7d8a9c17f441ecfcb605::version::Version, arg3: &mut QuestRegistry, arg4: bool, arg5: &0x2::tx_context::TxContext) {
        0x26dbda3f935362da3b6ad85abce3bc90b95507c156cc7d8a9c17f441ecfcb605::version::validate_version(arg2, 2);
        0x26dbda3f935362da3b6ad85abce3bc90b95507c156cc7d8a9c17f441ecfcb605::authority::is_valid_operator(arg0, 0x2::tx_context::sender(arg5), arg1);
        arg3.status = arg4;
        let v0 = ChangeQuestStatusEvent{
            sender : 0x2::tx_context::sender(arg5),
            status : arg4,
        };
        0x2::event::emit<ChangeQuestStatusEvent>(v0);
    }

    public fun claim_quest_ticket_airdrop_existing(arg0: &mut AirdropRegistry, arg1: &mut QuestRegistry, arg2: &0x26dbda3f935362da3b6ad85abce3bc90b95507c156cc7d8a9c17f441ecfcb605::version::Version, arg3: &mut QuestTicket, arg4: 0x1::string::String, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        0x26dbda3f935362da3b6ad85abce3bc90b95507c156cc7d8a9c17f441ecfcb605::version::validate_version(arg2, 2);
        validate_quest_status(arg1);
        let v0 = 0x2::dynamic_field::borrow_mut<0x1::string::String, DropConfig>(&mut arg0.id, arg4);
        assert!(v0.status, 6);
        let v1 = 0x2::tx_context::sender(arg6);
        assert!(0x1::vector::contains<address>(&v0.whitelisted_address, &v1), 5);
        let v2 = 0x2::tx_context::sender(arg6);
        let (_, v4) = 0x1::vector::index_of<address>(&v0.whitelisted_address, &v2);
        0x1::vector::remove<address>(&mut v0.whitelisted_address, v4);
        arg3.count = arg3.count + v0.airdrop_value;
        let v5 = ClaimAirdropExistingEvent{
            sender       : 0x2::tx_context::sender(arg6),
            ticket_id    : 0x2::object::id<QuestTicket>(arg3),
            airdrop_type : arg4,
            timestamp_ms : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<ClaimAirdropExistingEvent>(v5);
    }

    public fun claim_quest_ticket_airdrop_new(arg0: &mut AirdropRegistry, arg1: &mut QuestRegistry, arg2: &0x26dbda3f935362da3b6ad85abce3bc90b95507c156cc7d8a9c17f441ecfcb605::version::Version, arg3: 0x1::string::String, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x26dbda3f935362da3b6ad85abce3bc90b95507c156cc7d8a9c17f441ecfcb605::version::validate_version(arg2, 2);
        validate_quest_status(arg1);
        let v0 = 0x2::dynamic_field::borrow_mut<0x1::string::String, DropConfig>(&mut arg0.id, arg3);
        assert!(v0.status, 6);
        let v1 = 0x2::tx_context::sender(arg5);
        assert!(0x1::vector::contains<address>(&v0.whitelisted_address, &v1), 5);
        let v2 = 0x2::tx_context::sender(arg5);
        let (_, v4) = 0x1::vector::index_of<address>(&v0.whitelisted_address, &v2);
        0x2::table::add<address, u64>(&mut arg1.players, 0x2::tx_context::sender(arg5), v4);
        0x1::vector::remove<address>(&mut v0.whitelisted_address, v4);
        let v5 = new_ticket(v0.airdrop_value, arg5);
        0x2::transfer::transfer<QuestTicket>(v5, 0x2::tx_context::sender(arg5));
        let v6 = ClaimAirdropNewEvent{
            sender       : 0x2::tx_context::sender(arg5),
            airdrop_type : arg3,
            timestamp_ms : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<ClaimAirdropNewEvent>(v6);
    }

    public fun consume_ticket(arg0: &mut QuestRegistry, arg1: &mut QuestTicket, arg2: 0x1::string::String, arg3: u8, arg4: &0x2::tx_context::TxContext) {
        assert!(arg1.count >= arg3, 10);
        validate_quest_status(arg0);
        arg1.count = arg1.count - arg3;
        let v0 = TicketConsumedEvent{
            sender  : 0x2::tx_context::sender(arg4),
            message : arg2,
        };
        0x2::event::emit<TicketConsumedEvent>(v0);
    }

    public fun create_drop(arg0: &0x26dbda3f935362da3b6ad85abce3bc90b95507c156cc7d8a9c17f441ecfcb605::authority::OperatorCap, arg1: &0x26dbda3f935362da3b6ad85abce3bc90b95507c156cc7d8a9c17f441ecfcb605::authority::OperatorCapsBag, arg2: &0x26dbda3f935362da3b6ad85abce3bc90b95507c156cc7d8a9c17f441ecfcb605::version::Version, arg3: &mut AirdropRegistry, arg4: &0x2::clock::Clock, arg5: 0x1::string::String, arg6: vector<address>, arg7: bool, arg8: u8, arg9: &0x2::tx_context::TxContext) {
        0x26dbda3f935362da3b6ad85abce3bc90b95507c156cc7d8a9c17f441ecfcb605::authority::is_valid_operator(arg0, 0x2::tx_context::sender(arg9), arg1);
        0x26dbda3f935362da3b6ad85abce3bc90b95507c156cc7d8a9c17f441ecfcb605::version::validate_version(arg2, 2);
        let v0 = DropConfig{
            whitelisted_address : arg6,
            status              : arg7,
            airdrop_value       : arg8,
        };
        0x2::dynamic_field::add<0x1::string::String, DropConfig>(&mut arg3.id, arg5, v0);
        let v1 = CreateDropEvent{
            airdrop_name  : arg5,
            sender        : 0x2::tx_context::sender(arg9),
            timestamp     : 0x2::clock::timestamp_ms(arg4),
            airdrop_value : arg8,
        };
        0x2::event::emit<CreateDropEvent>(v1);
    }

    public(friend) fun decrease_ticket_count(arg0: &mut QuestTicket) {
        assert!(arg0.count >= 1, 2);
        arg0.count = arg0.count - 1;
    }

    public fun get_earn_point(arg0: &QuestRegistry) : u64 {
        arg0.gambit_earn_points
    }

    public fun get_ticket_count(arg0: &QuestTicket) : u8 {
        arg0.count
    }

    fun init(arg0: QUEST, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<QUEST>(arg0, arg1);
        let v1 = QuestRegistry{
            id                  : 0x2::object::new(arg1),
            admin_treasury      : 0x2::tx_context::sender(arg1),
            players             : 0x2::table::new<address, u64>(arg1),
            bundle_price        : 0x2::vec_map::empty<u8, u64>(),
            status              : false,
            gambit_earn_points  : 1,
            max_quest_point     : 250000,
            current_quest_point : 0,
        };
        let v2 = 0x2::display::new<QuestTicket>(&v0, arg1);
        0x2::display::add<QuestTicket>(&mut v2, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"Questing Tickets."));
        0x2::display::add<QuestTicket>(&mut v2, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"Tickets used for playing Season 2 of V Questing"));
        0x2::display::add<QuestTicket>(&mut v2, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://vendetta-assets.s3.eu-west-1.amazonaws.com/ticket_images/ticket.png"));
        0x2::display::update_version<QuestTicket>(&mut v2);
        let v3 = AirdropRegistry{id: 0x2::object::new(arg1)};
        0x2::transfer::share_object<QuestRegistry>(v1);
        0x2::transfer::share_object<AirdropRegistry>(v3);
        0x2::transfer::public_transfer<0x2::display::Display<QuestTicket>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    fun new_ticket(arg0: u8, arg1: &mut 0x2::tx_context::TxContext) : QuestTicket {
        QuestTicket{
            id    : 0x2::object::new(arg1),
            count : arg0,
        }
    }

    public fun update_admin_treasury(arg0: &0x26dbda3f935362da3b6ad85abce3bc90b95507c156cc7d8a9c17f441ecfcb605::authority::GovernorCap, arg1: &0x26dbda3f935362da3b6ad85abce3bc90b95507c156cc7d8a9c17f441ecfcb605::version::Version, arg2: &mut QuestRegistry, arg3: address, arg4: &0x2::tx_context::TxContext) {
        0x26dbda3f935362da3b6ad85abce3bc90b95507c156cc7d8a9c17f441ecfcb605::version::validate_version(arg1, 2);
        arg2.admin_treasury = arg3;
        let v0 = UpdateAdminTreasuryEvent{
            sender   : 0x2::tx_context::sender(arg4),
            treasury : arg3,
        };
        0x2::event::emit<UpdateAdminTreasuryEvent>(v0);
    }

    public fun update_drop_config(arg0: &0x26dbda3f935362da3b6ad85abce3bc90b95507c156cc7d8a9c17f441ecfcb605::authority::OperatorCap, arg1: &0x26dbda3f935362da3b6ad85abce3bc90b95507c156cc7d8a9c17f441ecfcb605::authority::OperatorCapsBag, arg2: &0x26dbda3f935362da3b6ad85abce3bc90b95507c156cc7d8a9c17f441ecfcb605::version::Version, arg3: &mut AirdropRegistry, arg4: &0x2::clock::Clock, arg5: 0x1::string::String, arg6: vector<address>, arg7: bool, arg8: u8, arg9: &0x2::tx_context::TxContext) {
        0x26dbda3f935362da3b6ad85abce3bc90b95507c156cc7d8a9c17f441ecfcb605::authority::is_valid_operator(arg0, 0x2::tx_context::sender(arg9), arg1);
        0x26dbda3f935362da3b6ad85abce3bc90b95507c156cc7d8a9c17f441ecfcb605::version::validate_version(arg2, 2);
        let v0 = 0x2::dynamic_field::borrow_mut<0x1::string::String, DropConfig>(&mut arg3.id, arg5);
        v0.airdrop_value = arg8;
        v0.whitelisted_address = arg6;
        v0.status = arg7;
        let v1 = UpdateDropEvent{
            airdrop_name  : arg5,
            sender        : 0x2::tx_context::sender(arg9),
            timestamp     : 0x2::clock::timestamp_ms(arg4),
            airdrop_value : arg8,
        };
        0x2::event::emit<UpdateDropEvent>(v1);
    }

    public fun update_gambit_earn_point(arg0: &0x26dbda3f935362da3b6ad85abce3bc90b95507c156cc7d8a9c17f441ecfcb605::authority::OperatorCap, arg1: &0x26dbda3f935362da3b6ad85abce3bc90b95507c156cc7d8a9c17f441ecfcb605::authority::OperatorCapsBag, arg2: &0x26dbda3f935362da3b6ad85abce3bc90b95507c156cc7d8a9c17f441ecfcb605::version::Version, arg3: &mut QuestRegistry, arg4: u64, arg5: &0x2::tx_context::TxContext) {
        0x26dbda3f935362da3b6ad85abce3bc90b95507c156cc7d8a9c17f441ecfcb605::version::validate_version(arg2, 2);
        0x26dbda3f935362da3b6ad85abce3bc90b95507c156cc7d8a9c17f441ecfcb605::authority::is_valid_operator(arg0, 0x2::tx_context::sender(arg5), arg1);
        arg3.gambit_earn_points = arg4;
        let v0 = UpdateGambitEarnPointEvent{
            sender             : 0x2::tx_context::sender(arg5),
            gambit_earn_points : arg4,
        };
        0x2::event::emit<UpdateGambitEarnPointEvent>(v0);
    }

    public fun update_whitelist_address(arg0: &0x26dbda3f935362da3b6ad85abce3bc90b95507c156cc7d8a9c17f441ecfcb605::authority::OperatorCap, arg1: &0x26dbda3f935362da3b6ad85abce3bc90b95507c156cc7d8a9c17f441ecfcb605::authority::OperatorCapsBag, arg2: &0x26dbda3f935362da3b6ad85abce3bc90b95507c156cc7d8a9c17f441ecfcb605::version::Version, arg3: &mut AirdropRegistry, arg4: 0x1::string::String, arg5: vector<address>, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        0x26dbda3f935362da3b6ad85abce3bc90b95507c156cc7d8a9c17f441ecfcb605::authority::is_valid_operator(arg0, 0x2::tx_context::sender(arg7), arg1);
        0x26dbda3f935362da3b6ad85abce3bc90b95507c156cc7d8a9c17f441ecfcb605::version::validate_version(arg2, 2);
        0x2::dynamic_field::borrow_mut<0x1::string::String, DropConfig>(&mut arg3.id, arg4).whitelisted_address = arg5;
        let v0 = UpdateWhiteListAddressEvent{
            airdrop_name : arg4,
            sender       : 0x2::tx_context::sender(arg7),
            timestamp    : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::event::emit<UpdateWhiteListAddressEvent>(v0);
    }

    public(friend) fun validate_quest_status(arg0: &QuestRegistry) {
        assert!(arg0.status, 7);
    }

    // decompiled from Move bytecode v6
}

