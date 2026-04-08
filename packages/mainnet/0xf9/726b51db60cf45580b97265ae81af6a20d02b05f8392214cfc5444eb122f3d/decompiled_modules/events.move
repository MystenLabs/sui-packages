module 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::events {
    struct LottoCreated<phantom T0> has copy, drop {
        lotto_id: 0x2::object::ID,
        lotto_version: u8,
        raffle_game_version: u8,
        name: 0x1::string::String,
        description: 0x1::string::String,
        lotto_type: u8,
        num_winners: u64,
        ticket_price: u64,
        end_time: u64,
    }

    struct LottoMigrated has copy, drop {
        lotto_id: 0x2::object::ID,
        old_lotto_version: u8,
        new_lotto_version: u8,
        old_raffle_game_version: u8,
        new_raffle_game_version: u8,
    }

    struct TicketsBought has copy, drop {
        lotto_id: 0x2::object::ID,
        buyer: address,
        num_tickets: u64,
        ticket_start: u64,
        ticket_end: u64,
        total_tickets_sold: u64,
    }

    struct WinnerCandidateDrawn has copy, drop, store {
        lotto_id: 0x2::object::ID,
        bucket_index: u64,
        drawn_ticket: u64,
        winner: address,
    }

    struct WinnerSelected has copy, drop {
        lotto_id: 0x2::object::ID,
        winner: address,
        random_index: u64,
        is_new_winner: bool,
    }

    struct FinalWinnersSelected has copy, drop {
        lotto_id: 0x2::object::ID,
        winners: 0x2::vec_set::VecSet<address>,
    }

    struct BucketWinnersSelected has copy, drop, store {
        lotto_id: 0x2::object::ID,
        bucket_index: u64,
        bucket_id: 0x2::object::ID,
        ticket_range_start: u64,
        ticket_range_end: u64,
        candidates_found: u64,
        total_buckets: u64,
        buckets_processed: u64,
    }

    struct PrizeClaimed has copy, drop {
        lotto_id: 0x2::object::ID,
        winner: address,
        amount: u64,
    }

    struct DustCollected has copy, drop {
        lotto_id: 0x2::object::ID,
        amount: u64,
    }

    struct LottoEnded<phantom T0> has copy, drop {
        lotto_id: 0x2::object::ID,
        lotto_type: u8,
        winners: 0x2::vec_set::VecSet<address>,
        winner_cut: u64,
        creator_cut: u64,
        suilotto_cut: u64,
        lotto_balance: u64,
        total_tickets_sold: u64,
    }

    struct RefundStarted has copy, drop {
        lotto_id: 0x2::object::ID,
        total_buckets: u64,
        total_participants: u64,
    }

    struct BucketRefunded has copy, drop {
        lotto_id: 0x2::object::ID,
        bucket_index: u64,
        bucket_id: 0x2::object::ID,
        participants_refunded: u64,
        total_refunded: u64,
        buckets_processed: u64,
        total_buckets: u64,
    }

    struct ParticipantRefunded has copy, drop {
        lotto_id: 0x2::object::ID,
        participant: address,
        amount: u64,
        num_tickets: u64,
    }

    struct LottoRefunded<phantom T0> has copy, drop {
        lotto_id: 0x2::object::ID,
        creator_refund: u64,
        total_participants_refunded: u64,
        lotto_balance: u64,
    }

    public(friend) fun emit_bucket_refunded(arg0: 0x2::object::ID, arg1: u64, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        let v0 = BucketRefunded{
            lotto_id              : arg0,
            bucket_index          : arg1,
            bucket_id             : arg2,
            participants_refunded : arg3,
            total_refunded        : arg4,
            buckets_processed     : arg5,
            total_buckets         : arg6,
        };
        0x2::event::emit<BucketRefunded>(v0);
    }

    public(friend) fun emit_bucket_winners_selected(arg0: 0x2::object::ID, arg1: u64, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64) {
        let v0 = BucketWinnersSelected{
            lotto_id           : arg0,
            bucket_index       : arg1,
            bucket_id          : arg2,
            ticket_range_start : arg3,
            ticket_range_end   : arg4,
            candidates_found   : arg5,
            total_buckets      : arg6,
            buckets_processed  : arg7,
        };
        0x2::event::emit<BucketWinnersSelected>(v0);
    }

    public(friend) fun emit_dust_collected(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = DustCollected{
            lotto_id : arg0,
            amount   : arg1,
        };
        0x2::event::emit<DustCollected>(v0);
    }

    public(friend) fun emit_final_winners_selected(arg0: 0x2::object::ID, arg1: 0x2::vec_set::VecSet<address>) {
        let v0 = FinalWinnersSelected{
            lotto_id : arg0,
            winners  : arg1,
        };
        0x2::event::emit<FinalWinnersSelected>(v0);
    }

    public(friend) fun emit_lotto_created<T0>(arg0: &0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::Lotto<T0>) {
        let v0 = 0x2::dynamic_object_field::borrow<0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::GameKey, 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::RaffleGame>(0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::lotto_id<T0>(arg0), 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::new_game_key());
        let v1 = LottoCreated<T0>{
            lotto_id            : 0x2::object::id<0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::Lotto<T0>>(arg0),
            lotto_version       : 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::current_lotto_version(),
            raffle_game_version : 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::current_raffle_game_version(),
            name                : 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::get_name<T0>(arg0),
            description         : 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::get_description<T0>(arg0),
            lotto_type          : 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::get_lotto_type<T0>(arg0),
            num_winners         : 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::game_num_winners(v0),
            ticket_price        : 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::game_ticket_price(v0),
            end_time            : 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::get_end_time<T0>(arg0),
        };
        0x2::event::emit<LottoCreated<T0>>(v1);
    }

    public(friend) fun emit_lotto_ended<T0>(arg0: 0x2::object::ID, arg1: u8, arg2: 0x2::vec_set::VecSet<address>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64) {
        let v0 = LottoEnded<T0>{
            lotto_id           : arg0,
            lotto_type         : arg1,
            winners            : arg2,
            winner_cut         : arg3,
            creator_cut        : arg4,
            suilotto_cut       : arg5,
            lotto_balance      : arg6,
            total_tickets_sold : arg7,
        };
        0x2::event::emit<LottoEnded<T0>>(v0);
    }

    public(friend) fun emit_lotto_migrated(arg0: 0x2::object::ID, arg1: u8, arg2: u8, arg3: u8, arg4: u8) {
        let v0 = LottoMigrated{
            lotto_id                : arg0,
            old_lotto_version       : arg1,
            new_lotto_version       : arg2,
            old_raffle_game_version : arg3,
            new_raffle_game_version : arg4,
        };
        0x2::event::emit<LottoMigrated>(v0);
    }

    public(friend) fun emit_lotto_refunded<T0>(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = LottoRefunded<T0>{
            lotto_id                    : arg0,
            creator_refund              : arg1,
            total_participants_refunded : arg2,
            lotto_balance               : arg3,
        };
        0x2::event::emit<LottoRefunded<T0>>(v0);
    }

    public(friend) fun emit_participant_refunded(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64) {
        let v0 = ParticipantRefunded{
            lotto_id    : arg0,
            participant : arg1,
            amount      : arg2,
            num_tickets : arg3,
        };
        0x2::event::emit<ParticipantRefunded>(v0);
    }

    public(friend) fun emit_prize_claimed(arg0: 0x2::object::ID, arg1: address, arg2: u64) {
        let v0 = PrizeClaimed{
            lotto_id : arg0,
            winner   : arg1,
            amount   : arg2,
        };
        0x2::event::emit<PrizeClaimed>(v0);
    }

    public(friend) fun emit_refund_started(arg0: 0x2::object::ID, arg1: u64, arg2: u64) {
        let v0 = RefundStarted{
            lotto_id           : arg0,
            total_buckets      : arg1,
            total_participants : arg2,
        };
        0x2::event::emit<RefundStarted>(v0);
    }

    public(friend) fun emit_tickets_bought(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = TicketsBought{
            lotto_id           : arg0,
            buyer              : arg1,
            num_tickets        : arg2,
            ticket_start       : arg3,
            ticket_end         : arg4,
            total_tickets_sold : arg5,
        };
        0x2::event::emit<TicketsBought>(v0);
    }

    public(friend) fun emit_winner_candidate_drawn(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: address) {
        let v0 = WinnerCandidateDrawn{
            lotto_id     : arg0,
            bucket_index : arg1,
            drawn_ticket : arg2,
            winner       : arg3,
        };
        0x2::event::emit<WinnerCandidateDrawn>(v0);
    }

    public(friend) fun emit_winner_selected(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: bool) {
        let v0 = WinnerSelected{
            lotto_id      : arg0,
            winner        : arg1,
            random_index  : arg2,
            is_new_winner : arg3,
        };
        0x2::event::emit<WinnerSelected>(v0);
    }

    // decompiled from Move bytecode v6
}

