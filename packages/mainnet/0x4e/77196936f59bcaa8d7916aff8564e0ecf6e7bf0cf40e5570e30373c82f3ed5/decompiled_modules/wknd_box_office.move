module 0x2f650a5162e4f7ef12b9adfbc2fadff1c30574572ebe2ed650b64a75f85b056b::wknd_box_office {
    struct WeekendBoxOffice has store, key {
        id: 0x2::object::UID,
        movies: 0x2::table::Table<u128, MovieData>,
        predictions: 0x2::table::Table<u128, Prediction>,
    }

    struct MovieData has copy, drop, store {
        imdb_id: 0x1::string::String,
        title: 0x1::string::String,
        genre: 0x1::string::String,
        finalized_week_datas: vector<FinalizedWeekData>,
    }

    struct Prediction has copy, drop, store {
        movie_id: u128,
        predicted_week: u64,
        predicted_revenue: 0x1::string::String,
        predicted_per_theater_avg: 0x1::string::String,
        predicted_rating: 0x1::string::String,
        predictor: address,
    }

    struct FinalizedWeekData has copy, drop, store {
        movie_id: u128,
        week: u64,
        revenue: 0x1::string::String,
        per_theater_avg: 0x1::string::String,
        rating: 0x1::string::String,
        imdb_id: 0x1::string::String,
        title: 0x1::string::String,
        genre: 0x1::string::String,
    }

    struct TicketData has copy, drop, store {
        movie_id: u128,
        imdb_id: 0x1::string::String,
        title: 0x1::string::String,
        genre: 0x1::string::String,
        week: u64,
        prediction_id: u128,
        predicted_revenue: 0x1::string::String,
        predicted_per_theater_avg: 0x1::string::String,
        predicted_rating: 0x1::string::String,
        predictor: address,
        actual_revenue: 0x1::string::String,
        actual_per_theater_avg: 0x1::string::String,
        actual_rating: 0x1::string::String,
        score: 0x1::string::String,
    }

    struct AddMovieEvent has copy, drop {
        movie_id: u128,
        imdb_id: 0x1::string::String,
        title: 0x1::string::String,
        genre: 0x1::string::String,
    }

    struct AddPredictionEvent has copy, drop {
        movie_id: u128,
        prediction_id: u128,
        predicted_week: u64,
        predicted_revenue: 0x1::string::String,
        predicted_per_theater_avg: 0x1::string::String,
        predicted_rating: 0x1::string::String,
        predictor: address,
        imdb_id: 0x1::string::String,
        title: 0x1::string::String,
        genre: 0x1::string::String,
    }

    struct FinalizeWeekDataEvent has copy, drop {
        week: u64,
        revenue: 0x1::string::String,
        per_theater_avg: 0x1::string::String,
        rating: 0x1::string::String,
        movie_id: u128,
        imdb_id: 0x1::string::String,
        title: 0x1::string::String,
        genre: 0x1::string::String,
    }

    public fun add_movie(arg0: &mut 0x2f650a5162e4f7ef12b9adfbc2fadff1c30574572ebe2ed650b64a75f85b056b::mogul::MogulCentral, arg1: &mut WeekendBoxOffice, arg2: u128, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) {
        0x2f650a5162e4f7ef12b9adfbc2fadff1c30574572ebe2ed650b64a75f85b056b::mogul::assert_valid_version_package(arg0);
        0x2f650a5162e4f7ef12b9adfbc2fadff1c30574572ebe2ed650b64a75f85b056b::mogul::assert_valid_manager_package(arg0, 0x2::tx_context::sender(arg6));
        let v0 = MovieData{
            imdb_id              : arg3,
            title                : arg4,
            genre                : arg5,
            finalized_week_datas : 0x1::vector::empty<FinalizedWeekData>(),
        };
        0x2::table::add<u128, MovieData>(&mut arg1.movies, arg2, v0);
        let v1 = AddMovieEvent{
            movie_id : arg2,
            imdb_id  : arg3,
            title    : arg4,
            genre    : arg5,
        };
        0x2::event::emit<AddMovieEvent>(v1);
    }

    public fun add_prediction(arg0: &mut 0x2f650a5162e4f7ef12b9adfbc2fadff1c30574572ebe2ed650b64a75f85b056b::mogul::MogulCentral, arg1: &mut WeekendBoxOffice, arg2: u128, arg3: u128, arg4: u64, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: address, arg9: &mut 0x2::tx_context::TxContext) {
        0x2f650a5162e4f7ef12b9adfbc2fadff1c30574572ebe2ed650b64a75f85b056b::mogul::assert_valid_version_package(arg0);
        0x2f650a5162e4f7ef12b9adfbc2fadff1c30574572ebe2ed650b64a75f85b056b::mogul::assert_valid_manager_package(arg0, 0x2::tx_context::sender(arg9));
        let v0 = 0x2::table::borrow<u128, MovieData>(&arg1.movies, arg2);
        let v1 = Prediction{
            movie_id                  : arg2,
            predicted_week            : arg4,
            predicted_revenue         : arg5,
            predicted_per_theater_avg : arg6,
            predicted_rating          : arg7,
            predictor                 : arg8,
        };
        0x2::table::add<u128, Prediction>(&mut arg1.predictions, arg3, v1);
        let v2 = AddPredictionEvent{
            movie_id                  : arg2,
            prediction_id             : arg3,
            predicted_week            : arg4,
            predicted_revenue         : arg5,
            predicted_per_theater_avg : arg6,
            predicted_rating          : arg7,
            predictor                 : arg8,
            imdb_id                   : v0.imdb_id,
            title                     : v0.title,
            genre                     : v0.genre,
        };
        0x2::event::emit<AddPredictionEvent>(v2);
    }

    public fun add_tickets(arg0: &mut 0x2f650a5162e4f7ef12b9adfbc2fadff1c30574572ebe2ed650b64a75f85b056b::mogul::MogulCentral, arg1: &mut WeekendBoxOffice, arg2: &mut 0x2f650a5162e4f7ef12b9adfbc2fadff1c30574572ebe2ed650b64a75f85b056b::ticket::TicketRegistry, arg3: u64, arg4: u64, arg5: u128, arg6: u128, arg7: u64, arg8: 0x1::string::String, arg9: address, arg10: &mut 0x2::tx_context::TxContext) {
        0x2f650a5162e4f7ef12b9adfbc2fadff1c30574572ebe2ed650b64a75f85b056b::mogul::assert_valid_version_package(arg0);
        0x2f650a5162e4f7ef12b9adfbc2fadff1c30574572ebe2ed650b64a75f85b056b::mogul::assert_valid_manager_package(arg0, 0x2::tx_context::sender(arg10));
        let v0 = 0x2::table::borrow<u128, MovieData>(&arg1.movies, arg5);
        let v1 = 0x2::table::borrow<u128, Prediction>(&arg1.predictions, arg6);
        let v2 = &v0.finalized_week_datas;
        let v3 = 0;
        let v4;
        while (v3 < 0x1::vector::length<FinalizedWeekData>(v2)) {
            if (arg7 == 0x1::vector::borrow<FinalizedWeekData>(v2, v3).week) {
                v4 = 0x1::option::some<u64>(v3);
                /* label 6 */
                let v5 = 0x1::vector::borrow<FinalizedWeekData>(&v0.finalized_week_datas, 0x1::option::destroy_some<u64>(v4));
                let v6 = TicketData{
                    movie_id                  : arg5,
                    imdb_id                   : v0.imdb_id,
                    title                     : v0.title,
                    genre                     : v0.genre,
                    week                      : v1.predicted_week,
                    prediction_id             : arg6,
                    predicted_revenue         : v1.predicted_revenue,
                    predicted_per_theater_avg : v1.predicted_per_theater_avg,
                    predicted_rating          : v1.predicted_rating,
                    predictor                 : v1.predictor,
                    actual_revenue            : v5.revenue,
                    actual_per_theater_avg    : v5.per_theater_avg,
                    actual_rating             : v5.rating,
                    score                     : arg8,
                };
                0x2f650a5162e4f7ef12b9adfbc2fadff1c30574572ebe2ed650b64a75f85b056b::ticket::give_ticket<TicketData>(arg2, arg0, arg3, 0x1::string::utf8(b"wknd_box_office"), v6, arg4, arg9, arg10);
                return
            };
            v3 = v3 + 1;
        };
        v4 = 0x1::option::none<u64>();
        /* goto 6 */
    }

    public fun create_weekend_box_office(arg0: &mut 0x2f650a5162e4f7ef12b9adfbc2fadff1c30574572ebe2ed650b64a75f85b056b::mogul::MogulCentral, arg1: &mut 0x2::tx_context::TxContext) {
        0x2f650a5162e4f7ef12b9adfbc2fadff1c30574572ebe2ed650b64a75f85b056b::mogul::assert_valid_version_package(arg0);
        0x2f650a5162e4f7ef12b9adfbc2fadff1c30574572ebe2ed650b64a75f85b056b::mogul::assert_valid_manager_package(arg0, 0x2::tx_context::sender(arg1));
        let v0 = WeekendBoxOffice{
            id          : 0x2::object::new(arg1),
            movies      : 0x2::table::new<u128, MovieData>(arg1),
            predictions : 0x2::table::new<u128, Prediction>(arg1),
        };
        0x2::transfer::public_share_object<WeekendBoxOffice>(v0);
    }

    public fun finalize_week_data(arg0: &mut 0x2f650a5162e4f7ef12b9adfbc2fadff1c30574572ebe2ed650b64a75f85b056b::mogul::MogulCentral, arg1: &mut WeekendBoxOffice, arg2: u128, arg3: u64, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: &mut 0x2::tx_context::TxContext) {
        0x2f650a5162e4f7ef12b9adfbc2fadff1c30574572ebe2ed650b64a75f85b056b::mogul::assert_valid_version_package(arg0);
        0x2f650a5162e4f7ef12b9adfbc2fadff1c30574572ebe2ed650b64a75f85b056b::mogul::assert_valid_manager_package(arg0, 0x2::tx_context::sender(arg7));
        let v0 = 0x2::table::borrow_mut<u128, MovieData>(&mut arg1.movies, arg2);
        let v1 = FinalizedWeekData{
            movie_id        : arg2,
            week            : arg3,
            revenue         : arg4,
            per_theater_avg : arg5,
            rating          : arg6,
            imdb_id         : v0.imdb_id,
            title           : v0.title,
            genre           : v0.genre,
        };
        0x1::vector::push_back<FinalizedWeekData>(&mut v0.finalized_week_datas, v1);
        let v2 = FinalizeWeekDataEvent{
            week            : arg3,
            revenue         : arg4,
            per_theater_avg : arg5,
            rating          : arg6,
            movie_id        : arg2,
            imdb_id         : v0.imdb_id,
            title           : v0.title,
            genre           : v0.genre,
        };
        0x2::event::emit<FinalizeWeekDataEvent>(v2);
    }

    // decompiled from Move bytecode v6
}

