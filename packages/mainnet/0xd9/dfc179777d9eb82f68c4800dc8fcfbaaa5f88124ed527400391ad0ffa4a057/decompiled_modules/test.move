module 0xd9dfc179777d9eb82f68c4800dc8fcfbaaa5f88124ed527400391ad0ffa4a057::test {
    struct EventConfig has store, key {
        id: 0x2::object::UID,
        description: 0x1::string::String,
    }

    struct Event has store, key {
        id: 0x2::object::UID,
        description: 0x1::string::String,
        expired_at: u64,
        visitors: 0x2::vec_set::VecSet<address>,
    }

    fun count_key() : 0x1::string::String {
        0x1::string::utf8(b"count")
    }

    public entry fun create_event(arg0: &mut EventConfig, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = Event{
            id          : 0x2::object::new(arg4),
            description : arg2,
            expired_at  : arg3,
            visitors    : 0x2::vec_set::empty<address>(),
        };
        0x2::dynamic_object_field::add<0x1::string::String, Event>(&mut arg0.id, event_key(), v0);
    }

    fun date_key() : 0x1::string::String {
        0x1::string::utf8(b"date_list")
    }

    fun event_key() : 0x1::string::String {
        0x1::string::utf8(b"event")
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = EventConfig{
            id          : 0x2::object::new(arg0),
            description : 0x1::string::utf8(b"Sui Japn Meetup POAP"),
        };
        0x2::transfer::share_object<EventConfig>(v0);
    }

    public fun mint(arg0: &mut Event, arg1: &0x2::clock::Clock, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg1) < arg0.expired_at, 1001);
        0x2::vec_set::insert<address>(&mut arg0.visitors, 0x2::tx_context::sender(arg6));
        let v0 = 0xd9dfc179777d9eb82f68c4800dc8fcfbaaa5f88124ed527400391ad0ffa4a057::nft::new(arg2, arg3, arg4, arg1, arg6);
        0x2::dynamic_field::add<0x1::string::String, u64>(0xd9dfc179777d9eb82f68c4800dc8fcfbaaa5f88124ed527400391ad0ffa4a057::nft::uid_mut_as_owner(&mut v0), count_key(), 1);
        0x2::dynamic_field::add<0x1::string::String, 0x2::vec_set::VecSet<0x1::string::String>>(0xd9dfc179777d9eb82f68c4800dc8fcfbaaa5f88124ed527400391ad0ffa4a057::nft::uid_mut_as_owner(&mut v0), date_key(), 0x2::vec_set::singleton<0x1::string::String>(arg5));
        0x2::transfer::public_transfer<0xd9dfc179777d9eb82f68c4800dc8fcfbaaa5f88124ed527400391ad0ffa4a057::nft::CoCoNFT>(v0, 0x2::tx_context::sender(arg6));
    }

    // decompiled from Move bytecode v6
}

