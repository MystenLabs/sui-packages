module 0x25da999c4c090fa8415f40b3ad3c219b83215bf32c11d84945e9c17941bda8f0::jackpot {
    struct JACKPOT has drop {
        dummy_field: bool,
    }

    struct Vault has key {
        id: 0x2::object::UID,
        jackpot: 0x2::balance::Balance<0x2::sui::SUI>,
        burn_bucket: 0x2::balance::Balance<0x2::sui::SUI>,
        ops: address,
        tickets_issued: u64,
        tickets_open: u64,
        wins: u64,
        total_paid_mist: u64,
        odds_denominator: u64,
        sui_since_win: u64,
        paused: bool,
    }

    struct Ticket has store {
        number: u64,
        weight_mist: u64,
        odds_denominator: u64,
        drought_x100: u64,
        owner: address,
        committed_at_ms: u64,
        vault_id: 0x2::object::ID,
    }

    struct Trophy has key {
        id: 0x2::object::UID,
        win_number: u64,
        payout_mist: u64,
        pot_at_win_mist: u64,
        won_at_ms: u64,
        winner: address,
        payout_display: 0x1::string::String,
        pot_display: 0x1::string::String,
        win_display: 0x1::string::String,
        lit_x: 0x1::string::String,
        lit_y: 0x1::string::String,
        lit_ty: 0x1::string::String,
        tier_display: 0x1::string::String,
    }

    struct Record has key {
        id: 0x2::object::UID,
        owner: address,
        commits: u64,
        total_committed_mist: u64,
        first_commit_ms: u64,
        last_commit_ms: u64,
        commits_display: 0x1::string::String,
        total_display: 0x1::string::String,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
    }

    struct KeeperCap has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
    }

    struct Committed has copy, drop {
        ticket_number: u64,
        buyer: address,
        committed_mist: u64,
        weight_mist: u64,
        odds_denominator: u64,
        vault_balance_after: u64,
    }

    struct Revealed has copy, drop {
        ticket_number: u64,
        buyer: address,
        won: bool,
        draw: u64,
        payout_mist: u64,
        vault_balance_after: u64,
        revealed_by: address,
    }

    struct Burned has copy, drop {
        amount_mist: u64,
    }

    struct BurnCreditKey has copy, drop, store {
        who: address,
    }

    struct TicketBoostKey has copy, drop, store {
        number: u64,
    }

    struct BoostCoinKey has copy, drop, store {
        dummy_field: bool,
    }

    struct BoostGrantsKey has copy, drop, store {
        dummy_field: bool,
    }

    struct BoostCoinNamed has copy, drop {
        coin: 0x1::type_name::TypeName,
    }

    struct BurnedForBoost has copy, drop {
        who: address,
        amount: u64,
        boost_x100: u64,
    }

    struct BoostSpent has copy, drop {
        who: address,
        ticket_number: u64,
        boost_x100: u64,
    }

    fun assert_cap(arg0: &AdminCap, arg1: &Vault) {
        assert!(arg0.vault_id == 0x2::object::id<Vault>(arg1), 8);
    }

    public fun boost_grants(arg0: &Vault) : u64 {
        let v0 = BoostGrantsKey{dummy_field: false};
        if (0x2::dynamic_field::exists_with_type<BoostGrantsKey, u64>(&arg0.id, v0)) {
            *0x2::dynamic_field::borrow<BoostGrantsKey, u64>(&arg0.id, v0)
        } else {
            0
        }
    }

    fun bump_boost_grants(arg0: &mut Vault) {
        let v0 = BoostGrantsKey{dummy_field: false};
        if (0x2::dynamic_field::exists_with_type<BoostGrantsKey, u64>(&arg0.id, v0)) {
            let v1 = 0x2::dynamic_field::borrow_mut<BoostGrantsKey, u64>(&mut arg0.id, v0);
            *v1 = *v1 + 1;
        } else {
            0x2::dynamic_field::add<BoostGrantsKey, u64>(&mut arg0.id, v0, 1);
        };
    }

    public fun burn_bucket_mist(arg0: &Vault) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.burn_bucket)
    }

    public fun burn_credit_x100(arg0: &Vault, arg1: address) : u64 {
        let v0 = BurnCreditKey{who: arg1};
        if (0x2::dynamic_field::exists_with_type<BurnCreditKey, u64>(&arg0.id, v0)) {
            *0x2::dynamic_field::borrow<BurnCreditKey, u64>(&arg0.id, v0)
        } else {
            100
        }
    }

    public fun burn_for_boost<T0>(arg0: &mut Vault, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 1);
        let v0 = BoostCoinKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists_with_type<BoostCoinKey, 0x1::type_name::TypeName>(&arg0.id, v0), 11);
        let v1 = BoostCoinKey{dummy_field: false};
        assert!(0x1::type_name::with_defining_ids<T0>() == *0x2::dynamic_field::borrow<BoostCoinKey, 0x1::type_name::TypeName>(&arg0.id, v1), 12);
        let v2 = 0x2::coin::value<T0>(&arg1);
        let v3 = tier_for(v2);
        let v4 = 0x2::tx_context::sender(arg2);
        let v5 = BurnCreditKey{who: v4};
        if (0x2::dynamic_field::exists_with_type<BurnCreditKey, u64>(&arg0.id, v5)) {
            assert!(v3 > *0x2::dynamic_field::borrow<BurnCreditKey, u64>(&arg0.id, v5), 14);
            0x2::dynamic_field::remove<BurnCreditKey, u64>(&mut arg0.id, v5);
        };
        0x2::dynamic_field::add<BurnCreditKey, u64>(&mut arg0.id, v5, v3);
        bump_boost_grants(arg0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, @0x0);
        let v6 = BurnedForBoost{
            who        : v4,
            amount     : v2,
            boost_x100 : v3,
        };
        0x2::event::emit<BurnedForBoost>(v6);
    }

    public fun commit(arg0: &mut Vault, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut Record, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(!arg0.paused, 1);
        assert!(arg2.owner == 0x2::tx_context::sender(arg4), 9);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 >= 1000000000, 2);
        let v1 = 0x2::coin::into_balance<0x2::sui::SUI>(arg1);
        let v2 = mul_div(v0, 100, 10000);
        let v3 = mul_div(v2, 7000, 10000);
        let v4 = mul_div(v2, 2000, 10000);
        let v5 = v2 - v3 - v4;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.jackpot, 0x2::balance::split<0x2::sui::SUI>(&mut v1, v3));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.burn_bucket, 0x2::balance::split<0x2::sui::SUI>(&mut v1, v4));
        if (v5 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v1, v5), arg4), arg0.ops);
        };
        let v6 = mul_div(arg0.odds_denominator * 1000000000, 2500, 10000);
        let v7 = if (v0 > v6) {
            v6
        } else {
            v0
        };
        let v8 = take_burn_credit(arg0, 0x2::tx_context::sender(arg4));
        arg0.tickets_issued = arg0.tickets_issued + 1;
        arg0.tickets_open = arg0.tickets_open + 1;
        let v9 = arg0.tickets_issued;
        let v10 = Ticket{
            number           : v9,
            weight_mist      : v7,
            odds_denominator : arg0.odds_denominator,
            drought_x100     : drought_multiplier_x100(arg0),
            owner            : 0x2::tx_context::sender(arg4),
            committed_at_ms  : 0x2::clock::timestamp_ms(arg3),
            vault_id         : 0x2::object::id<Vault>(arg0),
        };
        0x2::dynamic_field::add<u64, Ticket>(&mut arg0.id, v9, v10);
        if (v8 > 100) {
            let v11 = TicketBoostKey{number: v9};
            0x2::dynamic_field::add<TicketBoostKey, u64>(&mut arg0.id, v11, v8);
            let v12 = BoostSpent{
                who           : 0x2::tx_context::sender(arg4),
                ticket_number : v9,
                boost_x100    : v8,
            };
            0x2::event::emit<BoostSpent>(v12);
        };
        arg0.sui_since_win = arg0.sui_since_win + v0;
        arg2.commits = arg2.commits + 1;
        arg2.total_committed_mist = arg2.total_committed_mist + v0;
        arg2.last_commit_ms = 0x2::clock::timestamp_ms(arg3);
        arg2.commits_display = u64_to_string(arg2.commits);
        arg2.total_display = mist_to_string(arg2.total_committed_mist);
        let v13 = Committed{
            ticket_number       : v9,
            buyer               : 0x2::tx_context::sender(arg4),
            committed_mist      : v0,
            weight_mist         : v7,
            odds_denominator    : arg0.odds_denominator,
            vault_balance_after : 0x2::balance::value<0x2::sui::SUI>(&arg0.jackpot),
        };
        0x2::event::emit<Committed>(v13);
        0x2::coin::from_balance<0x2::sui::SUI>(v1, arg4)
    }

    public fun drought_multiplier_x100(arg0: &Vault) : u64 {
        let v0 = 100 + mul_div(arg0.sui_since_win, 100, arg0.odds_denominator * 1000000000);
        if (v0 > 400) {
            400
        } else {
            v0
        }
    }

    public fun effective_weight(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        let v0 = arg3 / 4;
        let v1 = mul_div(mul_div(arg0, arg1, 100), arg2, 100);
        if (v1 > v0) {
            v0
        } else {
            v1
        }
    }

    public fun has_record(arg0: &Vault, arg1: address) : bool {
        0x2::dynamic_field::exists_with_type<address, 0x2::object::ID>(&arg0.id, arg1)
    }

    public fun has_ticket(arg0: &Vault, arg1: u64) : bool {
        0x2::dynamic_field::exists_with_type<u64, Ticket>(&arg0.id, arg1)
    }

    fun init(arg0: JACKPOT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<JACKPOT>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Manifest369: The {tier_display}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Hit the {tier_display}. Took {payout_display} SUI from a pot of {pot_display} SUI. Win #{win_display}, soulbound and non-transferable."));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"data:image/svg+xml;utf8,<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 600 600'><defs><clipPath id='f'><rect x='24' y='24' width='552' height='552'/></clipPath><radialGradient id='h' cx='50%25' cy='50%25' r='50%25'><stop offset='0%25' stop-color='%23F5B01A' stop-opacity='0.34'/><stop offset='100%25' stop-color='%23F5B01A' stop-opacity='0'/></radialGradient></defs><rect width='600' height='600' fill='%23000'/><g clip-path='url(%23f)'><circle cx='{lit_x}' cy='{lit_y}' r='190' fill='url(%23h)'/></g><rect x='24' y='24' width='552' height='552' fill='none' stroke='%2327272A'/><text x='48' y='66' fill='%23F5B01A' font-family='Helvetica,Arial' font-size='19' font-weight='800'>MANIFEST369</text><text x='552' y='66' text-anchor='end' fill='%233F3F46' font-family='monospace' font-size='11'>WIN {win_display}</text><circle cx='300' cy='258' r='132' fill='none' stroke='%2318181B'/><path d='M 384.8 156.9 L 430.0 235.1 L 345.1 382.0 L 215.2 156.9 L 170.0 235.1 L 254.9 382.0 Z' fill='none' stroke='%2327272A' stroke-width='1.25'/><path d='M 414.3 324.0 L 185.7 324.0 L 300.0 126.0 Z' fill='none' stroke='%23F5B01A' stroke-width='1.75' opacity='0.75'/><circle cx='384.8' cy='156.9' r='13' fill='%23000' stroke='%2327272A'/><text x='384.8' y='160.9' text-anchor='middle' fill='%233F3F46' font-family='monospace' font-size='11'>1</text><circle cx='430.0' cy='235.1' r='13' fill='%23000' stroke='%2327272A'/><text x='430.0' y='239.1' text-anchor='middle' fill='%233F3F46' font-family='monospace' font-size='11'>2</text><circle cx='414.3' cy='324.0' r='19' fill='%23000' stroke='%23F5B01A' stroke-width='1.5'/><text x='414.3' y='330.0' text-anchor='middle' fill='%23F5B01A' font-family='monospace' font-size='15'>3</text><circle cx='345.1' cy='382.0' r='13' fill='%23000' stroke='%2327272A'/><text x='345.1' y='386.0' text-anchor='middle' fill='%233F3F46' font-family='monospace' font-size='11'>4</text><circle cx='254.9' cy='382.0' r='13' fill='%23000' stroke='%2327272A'/><text x='254.9' y='386.0' text-anchor='middle' fill='%233F3F46' font-family='monospace' font-size='11'>5</text><circle cx='185.7' cy='324.0' r='19' fill='%23000' stroke='%23F5B01A' stroke-width='1.5'/><text x='185.7' y='330.0' text-anchor='middle' fill='%23F5B01A' font-family='monospace' font-size='15'>6</text><circle cx='170.0' cy='235.1' r='13' fill='%23000' stroke='%2327272A'/><text x='170.0' y='239.1' text-anchor='middle' fill='%233F3F46' font-family='monospace' font-size='11'>7</text><circle cx='215.2' cy='156.9' r='13' fill='%23000' stroke='%2327272A'/><text x='215.2' y='160.9' text-anchor='middle' fill='%233F3F46' font-family='monospace' font-size='11'>8</text><circle cx='300.0' cy='126.0' r='19' fill='%23000' stroke='%23F5B01A' stroke-width='1.5'/><text x='300.0' y='132.0' text-anchor='middle' fill='%23F5B01A' font-family='monospace' font-size='15'>9</text><circle cx='{lit_x}' cy='{lit_y}' r='30' fill='%23F5B01A'/><text x='{lit_x}' y='{lit_ty}' text-anchor='middle' fill='%23000' font-family='Helvetica,Arial' font-size='30' font-weight='800'>{tier_display}</text><text x='48' y='470' fill='%2371717A' font-family='monospace' font-size='10' letter-spacing='3'>TOOK</text><text x='48' y='516' fill='%23FAFAFA' font-family='monospace' font-size='40' font-weight='700'>{payout_display}</text><text x='48' y='540' fill='%233F3F46' font-family='monospace' font-size='10' letter-spacing='4'>SUI</text><text x='552' y='470' text-anchor='end' fill='%2371717A' font-family='monospace' font-size='10' letter-spacing='3'>OF A POT OF</text><text x='552' y='504' text-anchor='end' fill='%2371717A' font-family='monospace' font-size='17'>{pot_display}</text><text x='552' y='540' text-anchor='end' fill='%2327272A' font-family='monospace' font-size='9' letter-spacing='2'>SOULBOUND</text></svg>"));
        let v5 = 0x2::display::new_with_fields<Trophy>(&v0, v1, v3, arg1);
        0x2::display::update_version<Trophy>(&mut v5);
        0x2::transfer::public_transfer<0x2::display::Display<Trophy>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = 0x1::vector::empty<0x1::string::String>();
        let v7 = &mut v6;
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"image_url"));
        let v8 = 0x1::vector::empty<0x1::string::String>();
        let v9 = &mut v8;
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"Manifest369 Record: {commits_display} commits"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"{total_display} SUI committed across {commits_display} commits. Soulbound and non-transferable."));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"data:image/svg+xml;utf8,<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 600 600'><rect width='600' height='600' fill='%23000'/><rect x='24' y='24' width='552' height='552' fill='none' stroke='%2327272A'/><text x='300' y='92' text-anchor='middle' fill='%23F5B01A' font-family='Helvetica,Arial' font-size='30' font-weight='800'>MANIFEST369</text><text x='300' y='120' text-anchor='middle' fill='%2371717A' font-family='monospace' font-size='11' letter-spacing='4'>RECORD OF CONVICTION</text><text x='300' y='285' text-anchor='middle' fill='%23FAFAFA' font-family='monospace' font-size='94' font-weight='700'>{commits_display}</text><text x='300' y='322' text-anchor='middle' fill='%2371717A' font-family='monospace' font-size='13' letter-spacing='6'>COMMITS</text><line x1='120' y1='372' x2='480' y2='372' stroke='%2327272A'/><text x='120' y='410' fill='%2371717A' font-family='monospace' font-size='11'>TOTAL COMMITTED</text><text x='480' y='410' text-anchor='end' fill='%23F5B01A' font-family='monospace' font-size='13'>{total_display} SUI</text><text x='300' y='540' text-anchor='middle' fill='%233F3F46' font-family='monospace' font-size='10'>SOULBOUND. EVERY ONE OF THESE WAS A CHOICE.</text></svg>"));
        let v10 = 0x2::display::new_with_fields<Record>(&v0, v6, v8, arg1);
        0x2::display::update_version<Record>(&mut v10);
        0x2::transfer::public_transfer<0x2::display::Display<Record>>(v10, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        let v11 = Vault{
            id               : 0x2::object::new(arg1),
            jackpot          : 0x2::balance::zero<0x2::sui::SUI>(),
            burn_bucket      : 0x2::balance::zero<0x2::sui::SUI>(),
            ops              : 0x2::tx_context::sender(arg1),
            tickets_issued   : 0,
            tickets_open     : 0,
            wins             : 0,
            total_paid_mist  : 0,
            odds_denominator : 3690,
            sui_since_win    : 0,
            paused           : false,
        };
        let v12 = 0x2::object::id<Vault>(&v11);
        let v13 = AdminCap{
            id       : 0x2::object::new(arg1),
            vault_id : v12,
        };
        0x2::transfer::transfer<AdminCap>(v13, 0x2::tx_context::sender(arg1));
        let v14 = KeeperCap{
            id       : 0x2::object::new(arg1),
            vault_id : v12,
        };
        0x2::transfer::transfer<KeeperCap>(v14, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<Vault>(v11);
    }

    public fun is_paused(arg0: &Vault) : bool {
        arg0.paused
    }

    public fun jackpot_mist(arg0: &Vault) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.jackpot)
    }

    public fun keep_record(arg0: Record, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 9);
        0x2::transfer::transfer<Record>(arg0, arg0.owner);
    }

    fun mist_to_string(arg0: u64) : 0x1::string::String {
        let v0 = arg0 % 1000000000 / 100000;
        let v1 = u64_to_string(arg0 / 1000000000);
        0x1::string::append(&mut v1, 0x1::string::utf8(b"."));
        if (v0 < 10) {
            0x1::string::append(&mut v1, 0x1::string::utf8(b"000"));
        } else if (v0 < 100) {
            0x1::string::append(&mut v1, 0x1::string::utf8(b"00"));
        } else if (v0 < 1000) {
            0x1::string::append(&mut v1, 0x1::string::utf8(b"0"));
        };
        0x1::string::append(&mut v1, u64_to_string(v0));
        v1
    }

    fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    public fun new_record(arg0: &mut Vault, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : Record {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(!0x2::dynamic_field::exists_with_type<address, 0x2::object::ID>(&arg0.id, v0), 10);
        let v1 = Record{
            id                   : 0x2::object::new(arg2),
            owner                : 0x2::tx_context::sender(arg2),
            commits              : 0,
            total_committed_mist : 0,
            first_commit_ms      : 0x2::clock::timestamp_ms(arg1),
            last_commit_ms       : 0x2::clock::timestamp_ms(arg1),
            commits_display      : 0x1::string::utf8(b"0"),
            total_display        : 0x1::string::utf8(b"0.0000"),
        };
        0x2::dynamic_field::add<address, 0x2::object::ID>(&mut arg0.id, v0, 0x2::object::id<Record>(&v1));
        v1
    }

    public fun odds_denominator(arg0: &Vault) : u64 {
        arg0.odds_denominator
    }

    public fun record_commits(arg0: &Record) : u64 {
        arg0.commits
    }

    public fun record_id(arg0: &Vault, arg1: address) : 0x2::object::ID {
        *0x2::dynamic_field::borrow<address, 0x2::object::ID>(&arg0.id, arg1)
    }

    public fun record_owner(arg0: &Record) : address {
        arg0.owner
    }

    public fun record_total_mist(arg0: &Record) : u64 {
        arg0.total_committed_mist
    }

    entry fun reveal(arg0: &mut Vault, arg1: u64, arg2: &0x2::random::Random, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let Ticket {
            number           : v0,
            weight_mist      : v1,
            odds_denominator : v2,
            drought_x100     : v3,
            owner            : v4,
            committed_at_ms  : v5,
            vault_id         : _,
        } = 0x2::dynamic_field::remove<u64, Ticket>(&mut arg0.id, arg1);
        let v7 = 0x2::clock::timestamp_ms(arg3);
        assert!(v7 >= v5 + 3000, 3);
        if (v7 < v5 + 2592000000) {
            assert!(0x2::tx_context::sender(arg4) == v4, 4);
        };
        let v8 = 0x2::balance::value<0x2::sui::SUI>(&arg0.jackpot);
        let v9 = v2 * 1000000000;
        let v10 = TicketBoostKey{number: arg1};
        let v11 = if (0x2::dynamic_field::exists_with_type<TicketBoostKey, u64>(&arg0.id, v10)) {
            0x2::dynamic_field::remove<TicketBoostKey, u64>(&mut arg0.id, v10)
        } else {
            100
        };
        let v12 = 0x2::random::new_generator(arg2, arg4);
        let v13 = 0x2::random::generate_u64_in_range(&mut v12, 0, v9);
        let v14 = 0x2::random::generate_u64_in_range(&mut v12, 0, 10000);
        let v15 = if (v14 < 9000) {
            800
        } else if (v14 < 9800) {
            3500
        } else {
            9500
        };
        let v16 = mul_div(v8, v15, 10000);
        let v17 = v13 < effective_weight(v1, v3, v11, v9) && v16 > 0;
        arg0.tickets_open = arg0.tickets_open - 1;
        let v18 = if (v17) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.jackpot, v16), arg4), v4);
            arg0.wins = arg0.wins + 1;
            arg0.total_paid_mist = arg0.total_paid_mist + v16;
            arg0.sui_since_win = 0;
            let v19 = if (v15 == 800) {
                0x1::string::utf8(b"3")
            } else if (v15 == 3500) {
                0x1::string::utf8(b"6")
            } else {
                0x1::string::utf8(b"9")
            };
            let v20 = if (v15 == 800) {
                0x1::string::utf8(b"414.3")
            } else if (v15 == 3500) {
                0x1::string::utf8(b"185.7")
            } else {
                0x1::string::utf8(b"300.0")
            };
            let v21 = if (v15 == 9500) {
                0x1::string::utf8(b"126.0")
            } else {
                0x1::string::utf8(b"324.0")
            };
            let v22 = if (v15 == 9500) {
                0x1::string::utf8(b"137.0")
            } else {
                0x1::string::utf8(b"335.0")
            };
            let v23 = Trophy{
                id              : 0x2::object::new(arg4),
                win_number      : arg0.wins,
                payout_mist     : v16,
                pot_at_win_mist : v8,
                won_at_ms       : v7,
                winner          : v4,
                payout_display  : mist_to_string(v16),
                pot_display     : mist_to_string(v8),
                win_display     : u64_to_string(arg0.wins),
                lit_x           : v20,
                lit_y           : v21,
                lit_ty          : v22,
                tier_display    : v19,
            };
            0x2::transfer::transfer<Trophy>(v23, v4);
            v16
        } else {
            0
        };
        let v24 = Revealed{
            ticket_number       : v0,
            buyer               : v4,
            won                 : v17,
            draw                : v13,
            payout_mist         : v18,
            vault_balance_after : 0x2::balance::value<0x2::sui::SUI>(&arg0.jackpot),
            revealed_by         : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<Revealed>(v24);
    }

    public fun set_boost_coin<T0>(arg0: &AdminCap, arg1: &mut Vault) {
        assert!(arg0.vault_id == 0x2::object::id<Vault>(arg1), 8);
        assert!(boost_grants(arg1) == 0, 15);
        let v0 = BoostCoinKey{dummy_field: false};
        if (0x2::dynamic_field::exists_with_type<BoostCoinKey, 0x1::type_name::TypeName>(&arg1.id, v0)) {
            0x2::dynamic_field::remove<BoostCoinKey, 0x1::type_name::TypeName>(&mut arg1.id, v0);
        };
        0x2::dynamic_field::add<BoostCoinKey, 0x1::type_name::TypeName>(&mut arg1.id, v0, 0x1::type_name::with_defining_ids<T0>());
        let v1 = BoostCoinNamed{coin: 0x1::type_name::with_defining_ids<T0>()};
        0x2::event::emit<BoostCoinNamed>(v1);
    }

    public fun set_odds_denominator(arg0: &AdminCap, arg1: &mut Vault, arg2: u64) {
        assert_cap(arg0, arg1);
        assert!(arg2 >= 3690 && arg2 <= 36900, 5);
        assert!(arg2 >= arg1.odds_denominator, 6);
        arg1.odds_denominator = arg2;
    }

    public fun set_ops(arg0: &AdminCap, arg1: &mut Vault, arg2: address) {
        assert_cap(arg0, arg1);
        arg1.ops = arg2;
    }

    public fun set_paused(arg0: &AdminCap, arg1: &mut Vault, arg2: bool) {
        assert_cap(arg0, arg1);
        arg1.paused = arg2;
    }

    public fun sui_since_win(arg0: &Vault) : u64 {
        arg0.sui_since_win
    }

    public fun take_burn_bucket(arg0: &KeeperCap, arg1: &mut Vault, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(arg0.vault_id == 0x2::object::id<Vault>(arg1), 8);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg1.burn_bucket);
        let v1 = Burned{amount_mist: v0};
        0x2::event::emit<Burned>(v1);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.burn_bucket, v0), arg2)
    }

    fun take_burn_credit(arg0: &mut Vault, arg1: address) : u64 {
        let v0 = BurnCreditKey{who: arg1};
        if (0x2::dynamic_field::exists_with_type<BurnCreditKey, u64>(&arg0.id, v0)) {
            0x2::dynamic_field::remove<BurnCreditKey, u64>(&mut arg0.id, v0)
        } else {
            100
        }
    }

    public fun ticket_boost_x100(arg0: &Vault, arg1: u64) : u64 {
        let v0 = TicketBoostKey{number: arg1};
        if (0x2::dynamic_field::exists_with_type<TicketBoostKey, u64>(&arg0.id, v0)) {
            *0x2::dynamic_field::borrow<TicketBoostKey, u64>(&arg0.id, v0)
        } else {
            100
        }
    }

    public fun tickets_issued(arg0: &Vault) : u64 {
        arg0.tickets_issued
    }

    public fun tickets_open(arg0: &Vault) : u64 {
        arg0.tickets_open
    }

    fun tier_for(arg0: u64) : u64 {
        if (arg0 == 690000000) {
            130
        } else if (arg0 == 6900000000) {
            200
        } else if (arg0 == 69000000000) {
            300
        } else if (arg0 == 6900000000000) {
            600
        } else {
            assert!(arg0 == 69000000000000, 13);
            900
        }
    }

    public fun top_up(arg0: &mut Vault, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.jackpot, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    public fun total_paid_mist(arg0: &Vault) : u64 {
        arg0.total_paid_mist
    }

    public fun trophy_payout_mist(arg0: &Trophy) : u64 {
        arg0.payout_mist
    }

    public fun trophy_pot_at_win_mist(arg0: &Trophy) : u64 {
        arg0.pot_at_win_mist
    }

    public fun trophy_win_number(arg0: &Trophy) : u64 {
        arg0.win_number
    }

    public fun trophy_winner(arg0: &Trophy) : address {
        arg0.winner
    }

    fun u64_to_string(arg0: u64) : 0x1::string::String {
        if (arg0 == 0) {
            return 0x1::string::utf8(b"0")
        };
        let v0 = 0x1::vector::empty<u8>();
        while (arg0 > 0) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 % 10) as u8) + 48);
            arg0 = arg0 / 10;
        };
        let v1 = 0x1::vector::empty<u8>();
        let v2 = 0x1::vector::length<u8>(&v0);
        while (v2 > 0) {
            v2 = v2 - 1;
            0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(&v0, v2));
        };
        0x1::string::utf8(v1)
    }

    public fun wins(arg0: &Vault) : u64 {
        arg0.wins
    }

    // decompiled from Move bytecode v7
}

