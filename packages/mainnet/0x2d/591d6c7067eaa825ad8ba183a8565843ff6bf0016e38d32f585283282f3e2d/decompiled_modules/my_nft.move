module 0x2d591d6c7067eaa825ad8ba183a8565843ff6bf0016e38d32f585283282f3e2d::my_nft {
    struct Puppy has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        traits: vector<0x1::string::String>,
        url: 0x1::string::String,
    }

    struct PuppyMinted has copy, drop {
        puppy_id: 0x2::object::ID,
        minted_by: address,
    }

    public fun add_trait(arg0: &mut Puppy, arg1: 0x1::string::String) {
        0x1::vector::push_back<0x1::string::String>(&mut arg0.traits, arg1);
    }

    public fun destroy(arg0: Puppy) {
        let Puppy {
            id     : v0,
            name   : _,
            traits : _,
            url    : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun mint(arg0: 0x1::string::String, arg1: vector<0x1::string::String>, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) : Puppy {
        let v0 = 0x2::object::new(arg3);
        let v1 = PuppyMinted{
            puppy_id  : 0x2::object::uid_to_inner(&v0),
            minted_by : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<PuppyMinted>(v1);
        Puppy{
            id     : v0,
            name   : arg0,
            traits : arg1,
            url    : arg2,
        }
    }

    public fun name(arg0: &Puppy) : 0x1::string::String {
        arg0.name
    }

    public fun set_url(arg0: &mut Puppy, arg1: 0x1::string::String) {
        arg0.url = arg1;
    }

    public fun traits(arg0: &Puppy) : &vector<0x1::string::String> {
        &arg0.traits
    }

    public fun url(arg0: &Puppy) : 0x1::string::String {
        arg0.url
    }

    // decompiled from Move bytecode v6
}

