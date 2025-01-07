module 0x6f6f312aab883a9f2b11b76a6a443bbc42d1c3a8b13ca373449da71393715f45::stamp {
    struct Stamp<phantom T0, T1: copy + drop + store> has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        container: T1,
    }

    struct StampMinted has copy, drop {
        minted_stamp_id: 0x2::object::ID,
    }

    struct StampBurnt has copy, drop {
        burnt_stamp_id: 0x2::object::ID,
    }

    public fun id<T0, T1: copy + drop + store>(arg0: &Stamp<T0, T1>) : 0x2::object::ID {
        0x2::object::id<Stamp<T0, T1>>(arg0)
    }

    public(friend) fun new<T0, T1: copy + drop + store>(arg0: &mut 0x6f6f312aab883a9f2b11b76a6a443bbc42d1c3a8b13ca373449da71393715f45::verification::Verifier, arg1: vector<u8>, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: T1, arg5: &0x2::clock::Clock, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) : Stamp<T0, T1> {
        0x6f6f312aab883a9f2b11b76a6a443bbc42d1c3a8b13ca373449da71393715f45::verification::verify_signature(arg0, 0x2::tx_context::sender(arg7), arg5, arg6, &mut arg1);
        let v0 = Stamp<T0, T1>{
            id        : 0x2::object::new(arg7),
            name      : arg2,
            image_url : arg3,
            container : arg4,
        };
        let v1 = StampMinted{minted_stamp_id: id<T0, T1>(&v0)};
        0x2::event::emit<StampMinted>(v1);
        v0
    }

    public fun container<T0, T1: copy + drop + store>(arg0: &Stamp<T0, T1>) : T1 {
        arg0.container
    }

    public fun destroy<T0, T1: copy + drop + store>(arg0: Stamp<T0, T1>) {
        let v0 = StampBurnt{burnt_stamp_id: id<T0, T1>(&arg0)};
        let Stamp {
            id        : v1,
            name      : _,
            image_url : _,
            container : _,
        } = arg0;
        0x2::object::delete(v1);
        0x2::event::emit<StampBurnt>(v0);
    }

    public fun image_url<T0, T1: copy + drop + store>(arg0: &Stamp<T0, T1>) : 0x1::string::String {
        arg0.image_url
    }

    public fun name<T0, T1: copy + drop + store>(arg0: &Stamp<T0, T1>) : 0x1::string::String {
        arg0.name
    }

    // decompiled from Move bytecode v6
}

