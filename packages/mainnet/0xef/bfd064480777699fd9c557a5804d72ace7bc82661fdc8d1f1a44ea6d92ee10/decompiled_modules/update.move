module 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update {
    struct Update has copy, drop {
        timestamp: u64,
        channel: 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::channel::Channel,
        feeds: vector<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed>,
    }

    public fun channel(arg0: &Update) : 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::channel::Channel {
        arg0.channel
    }

    public(friend) fun from_v2(arg0: 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update_v2::Update) : Update {
        Update{
            timestamp : 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update_v2::timestamp(&arg0),
            channel   : 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::channel::from_v2(0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update_v2::channel(&arg0)),
            feeds     : 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update_v2::feeds(&arg0),
        }
    }

    public fun feeds(arg0: &Update) : vector<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed> {
        arg0.feeds
    }

    public fun feeds_ref(arg0: &Update) : &vector<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed> {
        &arg0.feeds
    }

    public fun timestamp(arg0: &Update) : u64 {
        arg0.timestamp
    }

    // decompiled from Move bytecode v7
}

