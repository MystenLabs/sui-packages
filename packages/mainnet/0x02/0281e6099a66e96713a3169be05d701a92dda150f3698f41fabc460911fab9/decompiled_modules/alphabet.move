module 0x20281e6099a66e96713a3169be05d701a92dda150f3698f41fabc460911fab9::alphabet {
    struct ALPHABET has drop {
        dummy_field: bool,
    }

    struct Alphabet has store, key {
        id: 0x2::object::UID,
        letter: 0x1::string::String,
        color: 0x1::string::String,
        level: u64,
    }

    struct AlphabetCreatedEvent has copy, drop {
        player: address,
        alphabet_id: 0x2::object::ID,
        alphabet_letter: 0x1::string::String,
        alphabet_svg: 0x1::string::String,
    }

    public(friend) fun new(arg0: u8, arg1: &mut 0x2::tx_context::TxContext) : Alphabet {
        assert!(arg0 >= 65 && arg0 <= 90, 0);
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v0, arg0);
        Alphabet{
            id     : 0x2::object::new(arg1),
            letter : 0x1::string::utf8(v0),
            color  : 0x1::string::utf8(b"black"),
            level  : 0,
        }
    }

    public fun id(arg0: &Alphabet) : 0x2::object::ID {
        0x2::object::id<Alphabet>(arg0)
    }

    public fun build_alphabet_svg(arg0: vector<u8>) : vector<u8> {
        let v0 = b"";
        0x1::vector::append<u8>(&mut v0, b"<svg xmlns='http://www.w3.org/2000/svg' width='100' height='100' viewBox='0 0 100 100'>");
        0x1::vector::append<u8>(&mut v0, b"<text font-family='optima' x='50' y='80' font-size='80' text-anchor='middle' fill='{color}'>");
        0x1::vector::append<u8>(&mut v0, arg0);
        0x1::vector::append<u8>(&mut v0, b"</text>");
        0x1::vector::append<u8>(&mut v0, b"</svg>");
        v0
    }

    public(friend) fun create_all_alphabets(arg0: &mut 0x2::tx_context::TxContext) : vector<Alphabet> {
        let v0 = 65;
        let v1 = 0x1::vector::empty<Alphabet>();
        while (v0 < 91) {
            0x1::vector::push_back<Alphabet>(&mut v1, new(v0, arg0));
            v0 = v0 + 1;
        };
        v1
    }

    public(friend) fun create_alphabets(arg0: vector<u8>, arg1: &mut 0x2::tx_context::TxContext) : vector<Alphabet> {
        let v0 = 0;
        let v1 = 0x1::vector::empty<Alphabet>();
        while (v0 < 0x1::vector::length<u8>(&arg0)) {
            0x1::vector::push_back<Alphabet>(&mut v1, new(*0x1::vector::borrow<u8>(&arg0, v0), arg1));
            v0 = v0 + 1;
        };
        v1
    }

    public(friend) fun drop(arg0: Alphabet) {
        let Alphabet {
            id     : v0,
            letter : _,
            color  : _,
            level  : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public(friend) fun emit_created_event(arg0: address, arg1: 0x2::object::ID, arg2: 0x1::string::String) {
        let v0 = AlphabetCreatedEvent{
            player          : arg0,
            alphabet_id     : arg1,
            alphabet_letter : arg2,
            alphabet_svg    : 0x1::string::utf8(build_alphabet_svg(0x1::string::into_bytes(arg2))),
        };
        0x2::event::emit<AlphabetCreatedEvent>(v0);
    }

    fun init(arg0: ALPHABET, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<ALPHABET>(arg0, arg1);
        let v1 = 0x2::display::new<Alphabet>(&v0, arg1);
        let v2 = &mut v1;
        set_display(v2);
        0x2::transfer::public_transfer<0x2::display::Display<Alphabet>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun letter(arg0: &Alphabet) : 0x1::string::String {
        arg0.letter
    }

    public fun rare_letters() : vector<u8> {
        b"QXZ"
    }

    public(friend) fun set_color(arg0: &mut Alphabet, arg1: 0x1::string::String) {
        arg0.color = arg1;
    }

    fun set_display(arg0: &mut 0x2::display::Display<Alphabet>) {
        let v0 = 0x1::string::utf8(b"data:image/svg+xml;charset=utf8,");
        0x1::string::append(&mut v0, 0x1::string::utf8(build_alphabet_svg(b"{letter}")));
        0x2::display::add<Alphabet>(arg0, 0x1::string::utf8(b"image_url"), v0);
        0x2::display::add<Alphabet>(arg0, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"Alphabet {letter}"));
        0x2::display::update_version<Alphabet>(arg0);
    }

    public(friend) fun set_level(arg0: &mut Alphabet, arg1: u64) {
        arg0.level = arg1;
    }

    public(friend) fun uid_mut(arg0: &mut Alphabet) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public(friend) fun weighted_random_letter(arg0: &mut 0x2::random::RandomGenerator) : u8 {
        let v0 = 0x2::random::generate_u8_in_range(arg0, 0, 99);
        if (v0 < 60) {
            let v2 = b"ETAOINS";
            *0x1::vector::borrow<u8>(&v2, 0x2::random::generate_u64_in_range(arg0, 0, 6))
        } else if (v0 < 99) {
            let v3 = b"BCDFGHJKLMPRUVWY";
            *0x1::vector::borrow<u8>(&v3, 0x2::random::generate_u64_in_range(arg0, 0, 15))
        } else {
            let v4 = b"QXZ";
            *0x1::vector::borrow<u8>(&v4, 0x2::random::generate_u64_in_range(arg0, 0, 2))
        }
    }

    // decompiled from Move bytecode v6
}

