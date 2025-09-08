module 0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::rating_reputation {
    struct RatingRegistry has key {
        id: 0x2::object::UID,
        event_ratings: 0x2::table::Table<0x2::object::ID, EventRatings>,
        user_ratings: 0x2::table::Table<address, vector<UserRating>>,
        convener_ratings: 0x2::table::Table<address, ConvenerReputation>,
    }

    struct EventRatings has store {
        ratings: 0x2::table::Table<address, Rating>,
        total_rating_sum: u64,
        total_ratings: u64,
        average_rating: u64,
        rating_deadline: u64,
    }

    struct Rating has copy, drop, store {
        rater: address,
        event_rating: u64,
        convener_rating: u64,
        feedback: 0x1::string::String,
        timestamp: u64,
    }

    struct UserRating has copy, drop, store {
        event_id: 0x2::object::ID,
        rating_given: u64,
        timestamp: u64,
    }

    struct ConvenerReputation has store {
        total_events_rated: u64,
        total_rating_sum: u64,
        average_rating: u64,
        rating_history: vector<ConvenerRatingEntry>,
    }

    struct ConvenerRatingEntry has copy, drop, store {
        event_id: 0x2::object::ID,
        rating: u64,
        rater_count: u64,
        timestamp: u64,
    }

    struct RatingSubmitted has copy, drop {
        event_id: 0x2::object::ID,
        rater: address,
        event_rating: u64,
        convener_rating: u64,
        timestamp: u64,
    }

    struct ConvenerReputationUpdated has copy, drop {
        convener: address,
        new_average: u64,
        total_events: u64,
    }

    fun find_event_in_history(arg0: &vector<ConvenerRatingEntry>, arg1: 0x2::object::ID) : u64 {
        let v0 = 0;
        let v1 = 0x1::vector::length<ConvenerRatingEntry>(arg0);
        while (v0 < v1) {
            if (0x1::vector::borrow<ConvenerRatingEntry>(arg0, v0).event_id == arg1) {
                return v0
            };
            v0 = v0 + 1;
        };
        v1
    }

    public fun get_convener_rating_history(arg0: address, arg1: &RatingRegistry) : vector<ConvenerRatingEntry> {
        if (!0x2::table::contains<address, ConvenerReputation>(&arg1.convener_ratings, arg0)) {
            return 0x1::vector::empty<ConvenerRatingEntry>()
        };
        0x2::table::borrow<address, ConvenerReputation>(&arg1.convener_ratings, arg0).rating_history
    }

    public fun get_convener_reputation(arg0: address, arg1: &RatingRegistry) : (u64, u64, u64) {
        if (!0x2::table::contains<address, ConvenerReputation>(&arg1.convener_ratings, arg0)) {
            return (0, 0, 0)
        };
        let v0 = 0x2::table::borrow<address, ConvenerReputation>(&arg1.convener_ratings, arg0);
        (v0.total_events_rated, v0.average_rating, 0x1::vector::length<ConvenerRatingEntry>(&v0.rating_history))
    }

    public fun get_event_average_rating(arg0: 0x2::object::ID, arg1: &RatingRegistry) : u64 {
        if (!0x2::table::contains<0x2::object::ID, EventRatings>(&arg1.event_ratings, arg0)) {
            return 0
        };
        0x2::table::borrow<0x2::object::ID, EventRatings>(&arg1.event_ratings, arg0).average_rating
    }

    public fun get_event_rating_stats(arg0: 0x2::object::ID, arg1: &RatingRegistry) : (u64, u64, u64) {
        if (!0x2::table::contains<0x2::object::ID, EventRatings>(&arg1.event_ratings, arg0)) {
            return (0, 0, 0)
        };
        let v0 = 0x2::table::borrow<0x2::object::ID, EventRatings>(&arg1.event_ratings, arg0);
        (v0.total_ratings, v0.average_rating, v0.rating_deadline)
    }

    public fun get_user_rating(arg0: address, arg1: 0x2::object::ID, arg2: &RatingRegistry) : (u64, u64, 0x1::string::String) {
        let v0 = 0x2::table::borrow<address, Rating>(&0x2::table::borrow<0x2::object::ID, EventRatings>(&arg2.event_ratings, arg1).ratings, arg0);
        (v0.event_rating, v0.convener_rating, v0.feedback)
    }

    public fun has_user_rated(arg0: address, arg1: 0x2::object::ID, arg2: &RatingRegistry) : bool {
        if (!0x2::table::contains<0x2::object::ID, EventRatings>(&arg2.event_ratings, arg1)) {
            return false
        };
        0x2::table::contains<address, Rating>(&0x2::table::borrow<0x2::object::ID, EventRatings>(&arg2.event_ratings, arg1).ratings, arg0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = RatingRegistry{
            id               : 0x2::object::new(arg0),
            event_ratings    : 0x2::table::new<0x2::object::ID, EventRatings>(arg0),
            user_ratings     : 0x2::table::new<address, vector<UserRating>>(arg0),
            convener_ratings : 0x2::table::new<address, ConvenerReputation>(arg0),
        };
        0x2::transfer::share_object<RatingRegistry>(v0);
    }

    fun recalculate_convener_average(arg0: &mut ConvenerReputation) {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<ConvenerRatingEntry>(&arg0.rating_history)) {
            let v3 = 0x1::vector::borrow<ConvenerRatingEntry>(&arg0.rating_history, v2);
            v0 = v0 + v3.rating * v3.rater_count;
            v1 = v1 + v3.rater_count;
            v2 = v2 + 1;
        };
        if (v1 > 0) {
            arg0.total_rating_sum = v0;
            arg0.average_rating = v0 / v1;
        };
    }

    public fun submit_rating(arg0: &0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::event_management::Event, arg1: u64, arg2: u64, arg3: 0x1::string::String, arg4: &mut RatingRegistry, arg5: &0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::attendance_verification::AttendanceRegistry, arg6: &mut 0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::event_management::OrganizerProfile, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = 0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::event_management::get_event_id(arg0);
        let v2 = 0x2::clock::timestamp_ms(arg7);
        assert!(0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::event_management::is_event_completed(arg0), 5);
        assert!(0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::attendance_verification::verify_attendance_completion(v0, v1, arg5), 1);
        assert!(arg1 >= 100 && arg1 <= 500, 3);
        assert!(arg2 >= 100 && arg2 <= 500, 3);
        if (!0x2::table::contains<0x2::object::ID, EventRatings>(&arg4.event_ratings, v1)) {
            let v3 = EventRatings{
                ratings          : 0x2::table::new<address, Rating>(arg8),
                total_rating_sum : 0,
                total_ratings    : 0,
                average_rating   : 0,
                rating_deadline  : v2 + 604800000,
            };
            0x2::table::add<0x2::object::ID, EventRatings>(&mut arg4.event_ratings, v1, v3);
        };
        let v4 = 0x2::table::borrow_mut<0x2::object::ID, EventRatings>(&mut arg4.event_ratings, v1);
        assert!(v2 <= v4.rating_deadline, 4);
        assert!(!0x2::table::contains<address, Rating>(&v4.ratings, v0), 2);
        let v5 = Rating{
            rater           : v0,
            event_rating    : arg1,
            convener_rating : arg2,
            feedback        : arg3,
            timestamp       : v2,
        };
        0x2::table::add<address, Rating>(&mut v4.ratings, v0, v5);
        v4.total_rating_sum = v4.total_rating_sum + arg1;
        v4.total_ratings = v4.total_ratings + 1;
        v4.average_rating = v4.total_rating_sum / v4.total_ratings;
        if (!0x2::table::contains<address, vector<UserRating>>(&arg4.user_ratings, v0)) {
            0x2::table::add<address, vector<UserRating>>(&mut arg4.user_ratings, v0, 0x1::vector::empty<UserRating>());
        };
        let v6 = UserRating{
            event_id     : v1,
            rating_given : arg1,
            timestamp    : v2,
        };
        0x1::vector::push_back<UserRating>(0x2::table::borrow_mut<address, vector<UserRating>>(&mut arg4.user_ratings, v0), v6);
        update_convener_reputation(0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::event_management::get_event_organizer(arg0), v1, arg2, arg4, arg6, v2);
        let v7 = RatingSubmitted{
            event_id        : v1,
            rater           : v0,
            event_rating    : arg1,
            convener_rating : arg2,
            timestamp       : v2,
        };
        0x2::event::emit<RatingSubmitted>(v7);
    }

    fun update_convener_reputation(arg0: address, arg1: 0x2::object::ID, arg2: u64, arg3: &mut RatingRegistry, arg4: &mut 0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::event_management::OrganizerProfile, arg5: u64) {
        if (!0x2::table::contains<address, ConvenerReputation>(&arg3.convener_ratings, arg0)) {
            let v0 = ConvenerReputation{
                total_events_rated : 0,
                total_rating_sum   : 0,
                average_rating     : 0,
                rating_history     : 0x1::vector::empty<ConvenerRatingEntry>(),
            };
            0x2::table::add<address, ConvenerReputation>(&mut arg3.convener_ratings, arg0, v0);
        };
        let v1 = 0x2::table::borrow_mut<address, ConvenerReputation>(&mut arg3.convener_ratings, arg0);
        let v2 = find_event_in_history(&v1.rating_history, arg1);
        if (v2 < 0x1::vector::length<ConvenerRatingEntry>(&v1.rating_history)) {
            let v3 = 0x1::vector::borrow_mut<ConvenerRatingEntry>(&mut v1.rating_history, v2);
            v3.rater_count = v3.rater_count + 1;
            v3.rating = (v3.rating * v3.rater_count + arg2) / v3.rater_count;
            recalculate_convener_average(v1);
        } else {
            let v4 = ConvenerRatingEntry{
                event_id    : arg1,
                rating      : arg2,
                rater_count : 1,
                timestamp   : arg5,
            };
            0x1::vector::push_back<ConvenerRatingEntry>(&mut v1.rating_history, v4);
            v1.total_events_rated = v1.total_events_rated + 1;
            v1.total_rating_sum = v1.total_rating_sum + arg2;
            v1.average_rating = v1.total_rating_sum / v1.total_events_rated;
        };
        0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::event_management::update_organizer_rating(arg4, v1.total_rating_sum, v1.total_events_rated);
        let v5 = ConvenerReputationUpdated{
            convener     : arg0,
            new_average  : v1.average_rating,
            total_events : v1.total_events_rated,
        };
        0x2::event::emit<ConvenerReputationUpdated>(v5);
    }

    // decompiled from Move bytecode v6
}

