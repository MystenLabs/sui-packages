module 0x40bae404da586327e8357a05afb6e297acec2b38ba3d3618483a4bb85615bdd0::aifrens_game {
    struct GameConfig has key {
        id: 0x2::object::UID,
        referee_pk: vector<u8>,
        is_paused: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct ClanMembers has key {
        id: 0x2::object::UID,
        members: 0x2::table::Table<address, 0x2::object::ID>,
        total: u64,
    }

    struct Clan<phantom T0: key> has key {
        id: 0x2::object::UID,
        members: 0x2::table::Table<address, u64>,
        name: 0x1::string::String,
        url: 0x1::string::String,
        total: u64,
    }

    struct EnergyStore<phantom T0> has key {
        id: 0x2::object::UID,
        price: u64,
        balance: 0x2::balance::Balance<T0>,
    }

    struct Tournament<phantom T0> has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        slots: u64,
        entry_fee: u64,
        participants: 0x2::table::Table<address, u64>,
        balance: 0x2::balance::Balance<T0>,
        winners: 0x2::table::Table<address, u64>,
        reward: vector<u64>,
    }

    struct PvpRewardPool has key {
        id: 0x2::object::UID,
        rewards: 0x2::bag::Bag,
    }

    struct JoinClan<phantom T0: key> has copy, drop {
        user: address,
        clan_id: 0x2::object::ID,
    }

    struct EnergyBought<phantom T0> has copy, drop {
        user: address,
        amount: u64,
        point: u64,
    }

    struct TournamentRegistered<phantom T0> has copy, drop {
        user: address,
        tournament_id: 0x2::object::ID,
        amount: u64,
    }

    struct TournamentCreated has copy, drop {
        coin_type: 0x1::ascii::String,
        name: 0x1::string::String,
        tournament_id: 0x2::object::ID,
        slots: u64,
        entry_fee: u64,
        reward: vector<u64>,
    }

    struct PvpMatch has copy, drop {
        challenger: address,
        opponent: address,
        league_id: 0x1::string::String,
    }

    struct WinnerClaim has copy, drop {
        winner: address,
        tournament_id: 0x2::object::ID,
        reward: u64,
        rank: u64,
    }

    struct PvpClaim has copy, drop {
        sender: address,
        reward_id: 0x2::object::ID,
    }

    struct ClanCreated has copy, drop {
        token_type: 0x1::ascii::String,
        clan_id: 0x2::object::ID,
        name: 0x1::string::String,
        url: 0x1::string::String,
    }

    public fun admin_claim_tournament_reward<T0>(arg0: &mut Tournament<T0>, arg1: &AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.balance), arg3), arg2);
    }

    public fun admin_withdraw_energy_store<T0>(arg0: &mut EnergyStore<T0>, arg1: &AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.balance), arg3), arg2);
    }

    public fun buy_energy<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut EnergyStore<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::split<T0>(arg0, arg1 * arg2.price, arg3);
        0x2::balance::join<T0>(&mut arg2.balance, 0x2::coin::into_balance<T0>(v0));
        let v1 = EnergyBought<T0>{
            user   : 0x2::tx_context::sender(arg3),
            amount : 0x2::coin::value<T0>(&v0),
            point  : arg1,
        };
        0x2::event::emit<EnergyBought<T0>>(v1);
    }

    public fun claim_pvp_reward<T0: store + key>(arg0: &GameConfig, arg1: &mut PvpRewardPool, arg2: vector<u8>, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_paused, 5);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x1::bcs::to_bytes<address>(&v0);
        0x1::vector::append<u8>(&mut v1, 0x2::object::id_to_bytes(&arg3));
        assert!(0x2::ed25519::ed25519_verify(&arg2, &arg0.referee_pk, &v1), 6);
        0x2::transfer::public_transfer<T0>(0x2::bag::remove<0x2::object::ID, T0>(&mut arg1.rewards, arg3), v0);
        let v2 = PvpClaim{
            sender    : v0,
            reward_id : arg3,
        };
        0x2::event::emit<PvpClaim>(v2);
    }

    public fun claim_tournament_reward<T0>(arg0: &GameConfig, arg1: &mut Tournament<T0>, arg2: vector<u8>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_paused, 5);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(!0x2::table::contains<address, u64>(&arg1.winners, v0), 7);
        let v1 = 0x2::object::id<Tournament<T0>>(arg1);
        let v2 = 0x1::bcs::to_bytes<address>(&v0);
        0x1::vector::append<u8>(&mut v2, 0x2::object::id_to_bytes(&v1));
        0x1::vector::append<u8>(&mut v2, 0x1::bcs::to_bytes<u64>(&arg3));
        assert!(0x2::ed25519::ed25519_verify(&arg2, &arg0.referee_pk, &v2), 6);
        let v3 = 0x1::vector::borrow<u64>(&arg1.reward, arg3);
        0x2::table::add<address, u64>(&mut arg1.winners, v0, *v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance, *v3), arg4), v0);
        let v4 = WinnerClaim{
            winner        : v0,
            tournament_id : v1,
            reward        : *v3,
            rank          : arg3,
        };
        0x2::event::emit<WinnerClaim>(v4);
    }

    public fun create_clan<T0: store + key>(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: &AdminCap, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Clan<T0>{
            id      : 0x2::object::new(arg3),
            members : 0x2::table::new<address, u64>(arg3),
            name    : arg0,
            url     : arg1,
            total   : 0,
        };
        0x2::transfer::share_object<Clan<T0>>(v0);
        let v1 = ClanCreated{
            token_type : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            clan_id    : 0x2::object::id<Clan<T0>>(&v0),
            name       : arg0,
            url        : arg1,
        };
        0x2::event::emit<ClanCreated>(v1);
    }

    public fun create_energy_store<T0>(arg0: u64, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = EnergyStore<T0>{
            id      : 0x2::object::new(arg2),
            price   : arg0,
            balance : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::share_object<EnergyStore<T0>>(v0);
    }

    public fun create_game_config(arg0: &AdminCap, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = GameConfig{
            id         : 0x2::object::new(arg2),
            referee_pk : arg1,
            is_paused  : false,
        };
        0x2::transfer::share_object<GameConfig>(v0);
    }

    public fun create_tournament<T0>(arg0: u64, arg1: 0x1::string::String, arg2: u64, arg3: vector<u64>, arg4: &AdminCap, arg5: &mut 0x2::tx_context::TxContext) : Tournament<T0> {
        assert!(0x1::vector::length<u64>(&arg3) == 4, 8);
        let v0 = Tournament<T0>{
            id           : 0x2::object::new(arg5),
            name         : arg1,
            slots        : arg2,
            entry_fee    : arg0,
            participants : 0x2::table::new<address, u64>(arg5),
            balance      : 0x2::balance::zero<T0>(),
            winners      : 0x2::table::new<address, u64>(arg5),
            reward       : arg3,
        };
        let v1 = TournamentCreated{
            coin_type     : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            name          : arg1,
            tournament_id : 0x2::object::id<Tournament<T0>>(&v0),
            slots         : arg2,
            entry_fee     : arg0,
            reward        : arg3,
        };
        0x2::event::emit<TournamentCreated>(v1);
        v0
    }

    public fun deposit_pvp_reward<T0: store + key>(arg0: &mut PvpRewardPool, arg1: T0) {
        0x2::bag::add<0x2::object::ID, T0>(&mut arg0.rewards, 0x2::object::id<T0>(&arg1), arg1);
    }

    public fun fund_tournament<T0>(arg0: &mut Tournament<T0>, arg1: &mut 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg1, arg2, arg3)))
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PvpRewardPool{
            id      : 0x2::object::new(arg0),
            rewards : 0x2::bag::new(arg0),
        };
        0x2::transfer::share_object<PvpRewardPool>(v0);
        let v1 = ClanMembers{
            id      : 0x2::object::new(arg0),
            members : 0x2::table::new<address, 0x2::object::ID>(arg0),
            total   : 0,
        };
        0x2::transfer::share_object<ClanMembers>(v1);
        let v2 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v2, 0x2::tx_context::sender(arg0));
    }

    public fun join_clan<T0: store + key>(arg0: T0, arg1: &0x2::clock::Clock, arg2: &mut ClanMembers, arg3: &mut Clan<T0>, arg4: &mut 0x2::tx_context::TxContext) : T0 {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(!0x2::table::contains<address, 0x2::object::ID>(&arg2.members, v0), 1);
        0x2::table::add<address, u64>(&mut arg3.members, v0, 0x2::clock::timestamp_ms(arg1));
        arg3.total = arg3.total + 1;
        let v1 = 0x2::object::id<Clan<T0>>(arg3);
        0x2::table::add<address, 0x2::object::ID>(&mut arg2.members, v0, v1);
        arg2.total = arg2.total + 1;
        let v2 = JoinClan<T0>{
            user    : v0,
            clan_id : v1,
        };
        0x2::event::emit<JoinClan<T0>>(v2);
        arg0
    }

    public fun join_clan_with_kiosk<T0: store + key>(arg0: &0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock, arg4: &mut ClanMembers, arg5: &mut Clan<T0>, arg6: &mut 0x2::tx_context::TxContext) {
        0x2::kiosk::borrow<T0>(arg0, arg1, arg2);
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(!0x2::table::contains<address, 0x2::object::ID>(&arg4.members, v0), 1);
        0x2::table::add<address, u64>(&mut arg5.members, v0, 0x2::clock::timestamp_ms(arg3));
        arg5.total = arg5.total + 1;
        let v1 = 0x2::object::id<Clan<T0>>(arg5);
        0x2::table::add<address, 0x2::object::ID>(&mut arg4.members, v0, v1);
        arg4.total = arg4.total + 1;
        let v2 = JoinClan<T0>{
            user    : v0,
            clan_id : v1,
        };
        0x2::event::emit<JoinClan<T0>>(v2);
    }

    public fun leave_clan<T0: store + key>(arg0: &mut ClanMembers, arg1: &mut Clan<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, 0x2::object::ID>(&arg0.members, v0), 2);
        assert!(0x2::table::contains<address, u64>(&arg1.members, v0), 3);
        0x2::table::remove<address, u64>(&mut arg1.members, v0);
        arg1.total = arg1.total - 1;
        0x2::table::remove<address, 0x2::object::ID>(&mut arg0.members, v0);
        arg0.total = arg0.total - 1;
    }

    public fun new_admin(arg0: address, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg2)};
        0x2::transfer::transfer<AdminCap>(v0, arg0);
    }

    public fun register_tournament<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: &0x2::clock::Clock, arg2: &mut Tournament<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(!0x2::table::contains<address, u64>(&arg2.participants, v0), 1);
        assert!(0x2::table::length<address, u64>(&arg2.participants) < arg2.slots, 4);
        0x2::table::add<address, u64>(&mut arg2.participants, v0, 0x2::clock::timestamp_ms(arg1));
        let v1 = 0x2::coin::split<T0>(arg0, arg2.entry_fee, arg3);
        0x2::balance::join<T0>(&mut arg2.balance, 0x2::coin::into_balance<T0>(v1));
        let v2 = TournamentRegistered<T0>{
            user          : v0,
            tournament_id : 0x2::object::id<Tournament<T0>>(arg2),
            amount        : 0x2::coin::value<T0>(&v1),
        };
        0x2::event::emit<TournamentRegistered<T0>>(v2);
    }

    public fun start_pvp_match(arg0: address, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = PvpMatch{
            challenger : 0x2::tx_context::sender(arg2),
            opponent   : arg0,
            league_id  : arg1,
        };
        0x2::event::emit<PvpMatch>(v0);
    }

    public fun update_entry_fee_tournament<T0>(arg0: &mut Tournament<T0>, arg1: u64, arg2: &AdminCap) {
        arg0.entry_fee = arg1;
    }

    public fun update_pause_resume(arg0: &mut GameConfig, arg1: &AdminCap, arg2: bool) {
        arg0.is_paused = arg2;
    }

    public fun update_price_energy_store<T0>(arg0: &mut EnergyStore<T0>, arg1: u64, arg2: &AdminCap) {
        arg0.price = arg1;
    }

    public fun update_referee_pk(arg0: &mut GameConfig, arg1: &AdminCap, arg2: vector<u8>) {
        arg0.referee_pk = arg2;
    }

    public fun withdraw_pvp_reward<T0: store + key>(arg0: &mut PvpRewardPool, arg1: 0x2::object::ID, arg2: &AdminCap, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<T0>(0x2::bag::remove<0x2::object::ID, T0>(&mut arg0.rewards, arg1), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

