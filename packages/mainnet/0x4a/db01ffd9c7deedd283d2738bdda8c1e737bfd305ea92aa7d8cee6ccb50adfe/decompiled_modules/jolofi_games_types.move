module 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct OracleConfig has store, key {
        id: 0x2::object::UID,
        oracle_address: address,
    }

    struct VerifiedCallers has store, key {
        id: 0x2::object::UID,
        allowlist: 0x2::vec_set::VecSet<address>,
    }

    struct StakePool has store, key {
        id: 0x2::object::UID,
        total_stake: 0x2::balance::Balance<0x2::sui::SUI>,
        escrow_address: address,
    }

    struct Wallet has store, key {
        id: 0x2::object::UID,
        owner: address,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct GameState has store, key {
        id: 0x2::object::UID,
        requester: address,
        accepter: address,
        stake_amount: u64,
        system_fee: u64,
        is_external: bool,
        api_caller: address,
        game_id: vector<u8>,
    }

    struct GoldenChampion has store, key {
        id: 0x2::object::UID,
        owner: address,
        is_external: bool,
        last_game_timestamp: u64,
    }

    struct SilverChampion has store, key {
        id: 0x2::object::UID,
        owner: address,
        is_external: bool,
        last_game_timestamp: u64,
    }

    struct BronzeChampion has store, key {
        id: 0x2::object::UID,
        owner: address,
        is_external: bool,
        last_game_timestamp: u64,
    }

    struct Leaderboard has store, key {
        id: 0x2::object::UID,
        wins: 0x2::vec_map::VecMap<address, u64>,
        last_game_timestamp: 0x2::table::Table<address, u64>,
        external_wins: 0x2::table::Table<address, 0x2::vec_map::VecMap<address, u64>>,
        medals: 0x2::table::Table<address, u8>,
        external_medals: 0x2::table::Table<address, 0x2::vec_map::VecMap<address, u8>>,
    }

    struct MedalCheckState has store, key {
        id: 0x2::object::UID,
        last_check_timestamp: u64,
        check_interval_ms: u64,
    }

    struct TournamentRound has store, key {
        id: 0x2::object::UID,
        round_number: u64,
        pairings: 0x2::table::Table<address, address>,
        winners: 0x2::vec_set::VecSet<address>,
    }

    struct Tournament has store, key {
        id: 0x2::object::UID,
        creator: address,
        total_stake: 0x2::balance::Balance<0x2::sui::SUI>,
        players: 0x2::vec_set::VecSet<address>,
        stakes: 0x2::table::Table<address, u64>,
        stake_keys: vector<address>,
        scores: 0x2::table::Table<address, u64>,
        is_bracket: bool,
        payout_type: u8,
        active: bool,
        is_external: bool,
        api_caller: address,
        current_round: u64,
    }

    public fun admin_cap_id(arg0: &AdminCap) : &0x2::object::UID {
        &arg0.id
    }

    public fun bronze_champion_is_external(arg0: &BronzeChampion) : bool {
        arg0.is_external
    }

    public fun bronze_champion_last_game_timestamp(arg0: &BronzeChampion) : u64 {
        arg0.last_game_timestamp
    }

    public fun bronze_champion_owner(arg0: &BronzeChampion) : address {
        arg0.owner
    }

    public fun destroy_game_state(arg0: GameState) : (0x2::object::UID, address, address, u64, u64, bool, address, vector<u8>) {
        let GameState {
            id           : v0,
            requester    : v1,
            accepter     : v2,
            stake_amount : v3,
            system_fee   : v4,
            is_external  : v5,
            api_caller   : v6,
            game_id      : v7,
        } = arg0;
        (v0, v1, v2, v3, v4, v5, v6, v7)
    }

    public fun game_state_accepter(arg0: &GameState) : address {
        arg0.accepter
    }

    public fun game_state_api_caller(arg0: &GameState) : address {
        arg0.api_caller
    }

    public fun game_state_game_id(arg0: &GameState) : vector<u8> {
        arg0.game_id
    }

    public fun game_state_id(arg0: &GameState) : &0x2::object::UID {
        &arg0.id
    }

    public fun game_state_is_external(arg0: &GameState) : bool {
        arg0.is_external
    }

    public fun game_state_requester(arg0: &GameState) : address {
        arg0.requester
    }

    public fun game_state_stake_amount(arg0: &GameState) : u64 {
        arg0.stake_amount
    }

    public fun game_state_system_fee(arg0: &GameState) : u64 {
        arg0.system_fee
    }

    public fun golden_champion_is_external(arg0: &GoldenChampion) : bool {
        arg0.is_external
    }

    public fun golden_champion_last_game_timestamp(arg0: &GoldenChampion) : u64 {
        arg0.last_game_timestamp
    }

    public fun golden_champion_owner(arg0: &GoldenChampion) : address {
        arg0.owner
    }

    public fun leaderboard_external_medals(arg0: &Leaderboard) : &0x2::table::Table<address, 0x2::vec_map::VecMap<address, u8>> {
        &arg0.external_medals
    }

    public fun leaderboard_external_medals_mut(arg0: &mut Leaderboard) : &mut 0x2::table::Table<address, 0x2::vec_map::VecMap<address, u8>> {
        &mut arg0.external_medals
    }

    public fun leaderboard_external_wins(arg0: &Leaderboard) : &0x2::table::Table<address, 0x2::vec_map::VecMap<address, u64>> {
        &arg0.external_wins
    }

    public fun leaderboard_external_wins_mut(arg0: &mut Leaderboard) : &mut 0x2::table::Table<address, 0x2::vec_map::VecMap<address, u64>> {
        &mut arg0.external_wins
    }

    public fun leaderboard_id(arg0: &Leaderboard) : &0x2::object::UID {
        &arg0.id
    }

    public fun leaderboard_last_game_timestamp(arg0: &Leaderboard) : &0x2::table::Table<address, u64> {
        &arg0.last_game_timestamp
    }

    public fun leaderboard_last_game_timestamp_mut(arg0: &mut Leaderboard) : &mut 0x2::table::Table<address, u64> {
        &mut arg0.last_game_timestamp
    }

    public fun leaderboard_medals(arg0: &Leaderboard) : &0x2::table::Table<address, u8> {
        &arg0.medals
    }

    public fun leaderboard_medals_mut(arg0: &mut Leaderboard) : &mut 0x2::table::Table<address, u8> {
        &mut arg0.medals
    }

    public fun leaderboard_wins(arg0: &Leaderboard) : &0x2::vec_map::VecMap<address, u64> {
        &arg0.wins
    }

    public fun leaderboard_wins_mut(arg0: &mut Leaderboard) : &mut 0x2::vec_map::VecMap<address, u64> {
        &mut arg0.wins
    }

    public fun medal_check_state_check_interval_ms(arg0: &MedalCheckState) : u64 {
        arg0.check_interval_ms
    }

    public fun medal_check_state_id(arg0: &MedalCheckState) : &0x2::object::UID {
        &arg0.id
    }

    public fun medal_check_state_last_check_timestamp(arg0: &MedalCheckState) : u64 {
        arg0.last_check_timestamp
    }

    public fun medal_check_state_last_check_timestamp_mut(arg0: &mut MedalCheckState) : &mut u64 {
        &mut arg0.last_check_timestamp
    }

    public fun new_admin_cap(arg0: &mut 0x2::tx_context::TxContext) : AdminCap {
        AdminCap{id: 0x2::object::new(arg0)}
    }

    public fun new_bronze_champion(arg0: address, arg1: bool, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : BronzeChampion {
        BronzeChampion{
            id                  : 0x2::object::new(arg3),
            owner               : arg0,
            is_external         : arg1,
            last_game_timestamp : arg2,
        }
    }

    public fun new_game_state(arg0: address, arg1: address, arg2: u64, arg3: u64, arg4: bool, arg5: address, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) : GameState {
        GameState{
            id           : 0x2::object::new(arg7),
            requester    : arg0,
            accepter     : arg1,
            stake_amount : arg2,
            system_fee   : arg3,
            is_external  : arg4,
            api_caller   : arg5,
            game_id      : arg6,
        }
    }

    public fun new_golden_champion(arg0: address, arg1: bool, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : GoldenChampion {
        GoldenChampion{
            id                  : 0x2::object::new(arg3),
            owner               : arg0,
            is_external         : arg1,
            last_game_timestamp : arg2,
        }
    }

    public fun new_leaderboard(arg0: 0x2::vec_map::VecMap<address, u64>, arg1: 0x2::table::Table<address, u64>, arg2: 0x2::table::Table<address, 0x2::vec_map::VecMap<address, u64>>, arg3: 0x2::table::Table<address, u8>, arg4: 0x2::table::Table<address, 0x2::vec_map::VecMap<address, u8>>, arg5: &mut 0x2::tx_context::TxContext) : Leaderboard {
        Leaderboard{
            id                  : 0x2::object::new(arg5),
            wins                : arg0,
            last_game_timestamp : arg1,
            external_wins       : arg2,
            medals              : arg3,
            external_medals     : arg4,
        }
    }

    public fun new_medal_check_state(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : MedalCheckState {
        MedalCheckState{
            id                   : 0x2::object::new(arg2),
            last_check_timestamp : arg0,
            check_interval_ms    : arg1,
        }
    }

    public fun new_oracle_config(arg0: address, arg1: &mut 0x2::tx_context::TxContext) : OracleConfig {
        OracleConfig{
            id             : 0x2::object::new(arg1),
            oracle_address : arg0,
        }
    }

    public fun new_silver_champion(arg0: address, arg1: bool, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : SilverChampion {
        SilverChampion{
            id                  : 0x2::object::new(arg3),
            owner               : arg0,
            is_external         : arg1,
            last_game_timestamp : arg2,
        }
    }

    public fun new_stake_pool(arg0: 0x2::balance::Balance<0x2::sui::SUI>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : StakePool {
        StakePool{
            id             : 0x2::object::new(arg2),
            total_stake    : arg0,
            escrow_address : arg1,
        }
    }

    public fun new_tournament(arg0: address, arg1: 0x2::balance::Balance<0x2::sui::SUI>, arg2: 0x2::vec_set::VecSet<address>, arg3: 0x2::table::Table<address, u64>, arg4: vector<address>, arg5: 0x2::table::Table<address, u64>, arg6: bool, arg7: u8, arg8: bool, arg9: bool, arg10: address, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) : Tournament {
        Tournament{
            id            : 0x2::object::new(arg12),
            creator       : arg0,
            total_stake   : arg1,
            players       : arg2,
            stakes        : arg3,
            stake_keys    : arg4,
            scores        : arg5,
            is_bracket    : arg6,
            payout_type   : arg7,
            active        : arg8,
            is_external   : arg9,
            api_caller    : arg10,
            current_round : arg11,
        }
    }

    public fun new_tournament_round(arg0: u64, arg1: 0x2::table::Table<address, address>, arg2: 0x2::vec_set::VecSet<address>, arg3: &mut 0x2::tx_context::TxContext) : TournamentRound {
        TournamentRound{
            id           : 0x2::object::new(arg3),
            round_number : arg0,
            pairings     : arg1,
            winners      : arg2,
        }
    }

    public fun new_verified_callers(arg0: 0x2::vec_set::VecSet<address>, arg1: &mut 0x2::tx_context::TxContext) : VerifiedCallers {
        VerifiedCallers{
            id        : 0x2::object::new(arg1),
            allowlist : arg0,
        }
    }

    public fun new_wallet(arg0: address, arg1: 0x2::balance::Balance<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) : Wallet {
        Wallet{
            id      : 0x2::object::new(arg2),
            owner   : arg0,
            balance : arg1,
        }
    }

    public fun oracle_config_address(arg0: &OracleConfig) : address {
        arg0.oracle_address
    }

    public fun oracle_config_id(arg0: &OracleConfig) : &0x2::object::UID {
        &arg0.id
    }

    public fun share_game_state(arg0: GameState) {
        0x2::transfer::share_object<GameState>(arg0);
    }

    public fun share_tournament(arg0: Tournament) {
        0x2::transfer::share_object<Tournament>(arg0);
    }

    public fun silver_champion_is_external(arg0: &SilverChampion) : bool {
        arg0.is_external
    }

    public fun silver_champion_last_game_timestamp(arg0: &SilverChampion) : u64 {
        arg0.last_game_timestamp
    }

    public fun silver_champion_owner(arg0: &SilverChampion) : address {
        arg0.owner
    }

    public fun stake_pool_escrow_address(arg0: &StakePool) : address {
        arg0.escrow_address
    }

    public fun stake_pool_id(arg0: &StakePool) : &0x2::object::UID {
        &arg0.id
    }

    public fun stake_pool_total_stake(arg0: &StakePool) : &0x2::balance::Balance<0x2::sui::SUI> {
        &arg0.total_stake
    }

    public fun stake_pool_total_stake_mut(arg0: &mut StakePool) : &mut 0x2::balance::Balance<0x2::sui::SUI> {
        &mut arg0.total_stake
    }

    public fun tournament_active(arg0: &Tournament) : bool {
        arg0.active
    }

    public fun tournament_active_mut(arg0: &mut Tournament) : &mut bool {
        &mut arg0.active
    }

    public fun tournament_api_caller(arg0: &Tournament) : address {
        arg0.api_caller
    }

    public fun tournament_creator(arg0: &Tournament) : address {
        arg0.creator
    }

    public fun tournament_current_round(arg0: &Tournament) : u64 {
        arg0.current_round
    }

    public fun tournament_id(arg0: &Tournament) : &0x2::object::UID {
        &arg0.id
    }

    public fun tournament_is_bracket(arg0: &Tournament) : bool {
        arg0.is_bracket
    }

    public fun tournament_is_external(arg0: &Tournament) : bool {
        arg0.is_external
    }

    public fun tournament_payout_type(arg0: &Tournament) : u8 {
        arg0.payout_type
    }

    public fun tournament_players(arg0: &Tournament) : &0x2::vec_set::VecSet<address> {
        &arg0.players
    }

    public fun tournament_players_mut(arg0: &mut Tournament) : &mut 0x2::vec_set::VecSet<address> {
        &mut arg0.players
    }

    public fun tournament_round_id(arg0: &TournamentRound) : &0x2::object::UID {
        &arg0.id
    }

    public fun tournament_round_number(arg0: &TournamentRound) : u64 {
        arg0.round_number
    }

    public fun tournament_round_pairings(arg0: &TournamentRound) : &0x2::table::Table<address, address> {
        &arg0.pairings
    }

    public fun tournament_round_winners(arg0: &TournamentRound) : &0x2::vec_set::VecSet<address> {
        &arg0.winners
    }

    public fun tournament_round_winners_mut(arg0: &mut TournamentRound) : &mut 0x2::vec_set::VecSet<address> {
        &mut arg0.winners
    }

    public fun tournament_scores(arg0: &Tournament) : &0x2::table::Table<address, u64> {
        &arg0.scores
    }

    public fun tournament_scores_mut(arg0: &mut Tournament) : &mut 0x2::table::Table<address, u64> {
        &mut arg0.scores
    }

    public fun tournament_stake_keys(arg0: &Tournament) : &vector<address> {
        &arg0.stake_keys
    }

    public fun tournament_stake_keys_mut(arg0: &mut Tournament) : &mut vector<address> {
        &mut arg0.stake_keys
    }

    public fun tournament_stakes(arg0: &Tournament) : &0x2::table::Table<address, u64> {
        &arg0.stakes
    }

    public fun tournament_stakes_mut(arg0: &mut Tournament) : &mut 0x2::table::Table<address, u64> {
        &mut arg0.stakes
    }

    public fun tournament_total_stake(arg0: &Tournament) : &0x2::balance::Balance<0x2::sui::SUI> {
        &arg0.total_stake
    }

    public fun tournament_total_stake_mut(arg0: &mut Tournament) : &mut 0x2::balance::Balance<0x2::sui::SUI> {
        &mut arg0.total_stake
    }

    public fun transfer_admin_cap(arg0: AdminCap, arg1: address) {
        0x2::transfer::transfer<AdminCap>(arg0, arg1);
    }

    public fun verified_callers_allowlist(arg0: &VerifiedCallers) : &0x2::vec_set::VecSet<address> {
        &arg0.allowlist
    }

    public fun verified_callers_allowlist_mut(arg0: &mut VerifiedCallers) : &mut 0x2::vec_set::VecSet<address> {
        &mut arg0.allowlist
    }

    public fun verified_callers_id(arg0: &VerifiedCallers) : &0x2::object::UID {
        &arg0.id
    }

    public fun wallet_balance(arg0: &Wallet) : &0x2::balance::Balance<0x2::sui::SUI> {
        &arg0.balance
    }

    public fun wallet_balance_mut(arg0: &mut Wallet) : &mut 0x2::balance::Balance<0x2::sui::SUI> {
        &mut arg0.balance
    }

    public fun wallet_id(arg0: &Wallet) : &0x2::object::UID {
        &arg0.id
    }

    public fun wallet_owner(arg0: &Wallet) : address {
        arg0.owner
    }

    // decompiled from Move bytecode v6
}

