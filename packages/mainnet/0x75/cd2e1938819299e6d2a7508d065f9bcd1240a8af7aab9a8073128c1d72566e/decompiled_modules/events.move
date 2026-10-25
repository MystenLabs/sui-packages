module 0x75cd2e1938819299e6d2a7508d065f9bcd1240a8af7aab9a8073128c1d72566e::events {
    struct LaunchCreated has copy, drop {
        launch_id: 0x2::object::ID,
        meme: 0x1::type_name::TypeName,
        quote: 0x1::type_name::TypeName,
        creator: address,
        virtual_quote: u64,
        graduation_target: u64,
        opening_round_ms: u64,
    }

    struct LaunchShared has copy, drop {
        launch_id: 0x2::object::ID,
        public_start_ms: u64,
    }

    struct Bought has copy, drop {
        launch_id: 0x2::object::ID,
        buyer: address,
        quote_in: u64,
        quote_fee: u64,
        meme_out_net: u64,
        meme_fee: u64,
        quote_refund: u64,
        real_quote_reserve: u64,
        meme_reserve: u64,
    }

    struct Sold has copy, drop {
        launch_id: 0x2::object::ID,
        seller: address,
        meme_in_gross: u64,
        meme_fee: u64,
        meme_burned: u64,
        quote_out_gross: u64,
        protocol_quote_fee: u64,
        creator_quote_fee: u64,
        real_quote_reserve: u64,
        meme_reserve: u64,
    }

    struct OpeningRoundJoined has copy, drop {
        launch_id: 0x2::object::ID,
        bidder: address,
        amount: u64,
        bid: u64,
        pot: u64,
    }

    struct OpeningRoundSettled has copy, drop {
        launch_id: 0x2::object::ID,
        pot: u64,
        meme_out: u64,
        quote_refund: u64,
    }

    struct OpeningRoundDelivered has copy, drop {
        launch_id: 0x2::object::ID,
        bidder: address,
        meme: u64,
        quote: u64,
    }

    struct MigrationReady has copy, drop {
        launch_id: 0x2::object::ID,
        real_quote_reserve: u64,
    }

    struct Migrated has copy, drop {
        launch_id: 0x2::object::ID,
        quote: u64,
        meme: u64,
    }

    public(friend) fun bought(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64) {
        let v0 = Bought{
            launch_id          : arg0,
            buyer              : arg1,
            quote_in           : arg2,
            quote_fee          : arg3,
            meme_out_net       : arg4,
            meme_fee           : arg5,
            quote_refund       : arg6,
            real_quote_reserve : arg7,
            meme_reserve       : arg8,
        };
        0x75cd2e1938819299e6d2a7508d065f9bcd1240a8af7aab9a8073128c1d72566e::blast_events::emit<Bought>(v0);
    }

    public(friend) fun launch_created(arg0: 0x2::object::ID, arg1: 0x1::type_name::TypeName, arg2: 0x1::type_name::TypeName, arg3: address, arg4: u64, arg5: u64, arg6: u64) {
        let v0 = LaunchCreated{
            launch_id         : arg0,
            meme              : arg1,
            quote             : arg2,
            creator           : arg3,
            virtual_quote     : arg4,
            graduation_target : arg5,
            opening_round_ms  : arg6,
        };
        0x75cd2e1938819299e6d2a7508d065f9bcd1240a8af7aab9a8073128c1d72566e::blast_events::emit<LaunchCreated>(v0);
    }

    public(friend) fun launch_shared(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = LaunchShared{
            launch_id       : arg0,
            public_start_ms : arg1,
        };
        0x75cd2e1938819299e6d2a7508d065f9bcd1240a8af7aab9a8073128c1d72566e::blast_events::emit<LaunchShared>(v0);
    }

    public(friend) fun migrated(arg0: 0x2::object::ID, arg1: u64, arg2: u64) {
        let v0 = Migrated{
            launch_id : arg0,
            quote     : arg1,
            meme      : arg2,
        };
        0x75cd2e1938819299e6d2a7508d065f9bcd1240a8af7aab9a8073128c1d72566e::blast_events::emit<Migrated>(v0);
    }

    public(friend) fun migration_ready(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = MigrationReady{
            launch_id          : arg0,
            real_quote_reserve : arg1,
        };
        0x75cd2e1938819299e6d2a7508d065f9bcd1240a8af7aab9a8073128c1d72566e::blast_events::emit<MigrationReady>(v0);
    }

    public(friend) fun opening_round_delivered(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64) {
        let v0 = OpeningRoundDelivered{
            launch_id : arg0,
            bidder    : arg1,
            meme      : arg2,
            quote     : arg3,
        };
        0x75cd2e1938819299e6d2a7508d065f9bcd1240a8af7aab9a8073128c1d72566e::blast_events::emit<OpeningRoundDelivered>(v0);
    }

    public(friend) fun opening_round_joined(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = OpeningRoundJoined{
            launch_id : arg0,
            bidder    : arg1,
            amount    : arg2,
            bid       : arg3,
            pot       : arg4,
        };
        0x75cd2e1938819299e6d2a7508d065f9bcd1240a8af7aab9a8073128c1d72566e::blast_events::emit<OpeningRoundJoined>(v0);
    }

    public(friend) fun opening_round_settled(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = OpeningRoundSettled{
            launch_id    : arg0,
            pot          : arg1,
            meme_out     : arg2,
            quote_refund : arg3,
        };
        0x75cd2e1938819299e6d2a7508d065f9bcd1240a8af7aab9a8073128c1d72566e::blast_events::emit<OpeningRoundSettled>(v0);
    }

    public(friend) fun sold(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64) {
        let v0 = Sold{
            launch_id          : arg0,
            seller             : arg1,
            meme_in_gross      : arg2,
            meme_fee           : arg3,
            meme_burned        : arg4,
            quote_out_gross    : arg5,
            protocol_quote_fee : 0,
            creator_quote_fee  : arg6,
            real_quote_reserve : arg7,
            meme_reserve       : arg8,
        };
        0x75cd2e1938819299e6d2a7508d065f9bcd1240a8af7aab9a8073128c1d72566e::blast_events::emit<Sold>(v0);
    }

    // decompiled from Move bytecode v7
}

