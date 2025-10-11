module 0xf7a3be73414ad81f015be72f4a79a8097096d4b0ccb5578383dfe43030149bd7::contribution {
    struct WarlotData has drop, store {
        interaction_points: u64,
        last_interaction_time: u64,
    }

    public(friend) fun create() : WarlotData {
        WarlotData{
            interaction_points    : 0,
            last_interaction_time : 0,
        }
    }

    public(friend) fun destroy(arg0: WarlotData) {
        let WarlotData {
            interaction_points    : _,
            last_interaction_time : _,
        } = arg0;
    }

    public fun interaction_points(arg0: &WarlotData) : u64 {
        arg0.interaction_points
    }

    public fun last_interaction_time(arg0: &WarlotData) : u64 {
        arg0.last_interaction_time
    }

    public(friend) fun update_points(arg0: &mut WarlotData, arg1: u64, arg2: &0x2::clock::Clock) {
        arg0.interaction_points = arg0.interaction_points + arg1;
        arg0.last_interaction_time = 0x2::clock::timestamp_ms(arg2);
    }

    // decompiled from Move bytecode v6
}

