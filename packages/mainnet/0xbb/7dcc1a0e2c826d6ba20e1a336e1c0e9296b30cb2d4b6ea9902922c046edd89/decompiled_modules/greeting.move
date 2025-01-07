module 0xbb7dcc1a0e2c826d6ba20e1a336e1c0e9296b30cb2d4b6ea9902922c046edd89::greeting {
    struct Greeting has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        emoji: u8,
    }

    struct GREETING has drop {
        dummy_field: bool,
    }

    struct EventGreetingCreated has copy, drop {
        greeting_id: 0x2::object::ID,
    }

    struct EventGreetingSet has copy, drop {
        greeting_id: 0x2::object::ID,
    }

    struct EventGreetingReset has copy, drop {
        greeting_id: 0x2::object::ID,
    }

    fun new(arg0: &mut 0x2::tx_context::TxContext) : Greeting {
        Greeting{
            id    : 0x2::object::new(arg0),
            name  : 0x1::string::utf8(b""),
            emoji : 0,
        }
    }

    public fun create(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = new(arg0);
        let v1 = EventGreetingCreated{greeting_id: 0x2::object::uid_to_inner(&v0.id)};
        0x2::event::emit<EventGreetingCreated>(v1);
        0x2::transfer::transfer<Greeting>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun emoji(arg0: &Greeting) : u8 {
        arg0.emoji
    }

    fun init(arg0: GREETING, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"license"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Greetings to {name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://demo.sui-dapp-starter.dev/emoji/{emoji}.svg"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Demonstrates Sui Object Display feature"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://demo.sui-dapp-starter.dev"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Sui dApp Starter"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Graphics borrowed from https://github.com/twitter/twemoji and licensed under CC-BY 4.0: https://creativecommons.org/licenses/by/4.0/"));
        let v4 = 0x2::package::claim<GREETING>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<Greeting>(&v4, v0, v2, arg1);
        0x2::display::update_version<Greeting>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Greeting>>(v5, 0x2::tx_context::sender(arg1));
    }

    public fun name(arg0: &Greeting) : 0x1::string::String {
        arg0.name
    }

    public fun reset_greeting(arg0: &mut Greeting) {
        arg0.name = 0x1::string::utf8(b"");
        arg0.emoji = 0;
        let v0 = EventGreetingReset{greeting_id: 0x2::object::uid_to_inner(&arg0.id)};
        0x2::event::emit<EventGreetingReset>(v0);
    }

    entry fun set_greeting(arg0: &mut Greeting, arg1: 0x1::string::String, arg2: &0x2::random::Random, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 != 0x1::string::utf8(b""), 0);
        let v0 = 0x2::random::new_generator(arg2, arg3);
        arg0.name = arg1;
        arg0.emoji = 0x2::random::generate_u8_in_range(&mut v0, 1, 64);
        let v1 = EventGreetingSet{greeting_id: 0x2::object::uid_to_inner(&arg0.id)};
        0x2::event::emit<EventGreetingSet>(v1);
    }

    // decompiled from Move bytecode v6
}

