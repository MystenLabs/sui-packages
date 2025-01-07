module 0x141d8a2333f9369452fe075331924bb98d2abf0ee98de941db85aaf809c4ef54::aeon {
    struct AeonClaimed has copy, drop, store {
        dummy_field: bool,
    }

    struct Aeon has store, key {
        id: 0x2::object::UID,
        image: 0x1::string::String,
        club_id: u16,
        name_id: 0x1::string::String,
        color: 0x1::string::String,
        theme: 0x1::string::String,
    }

    struct AeonCap has key {
        id: 0x2::object::UID,
        max_id: u16,
        current: u16,
    }

    public fun burn_cap(arg0: AeonCap) {
        assert!(arg0.current > arg0.max_id, 1);
        let AeonCap {
            id      : v0,
            max_id  : _,
            current : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun club_id(arg0: &Aeon) : u16 {
        arg0.club_id
    }

    public fun color(arg0: &Aeon) : 0x1::string::String {
        arg0.color
    }

    public fun id(arg0: &Aeon) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun image(arg0: &Aeon) : 0x1::string::String {
        arg0.image
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AeonCap{
            id      : 0x2::object::new(arg0),
            max_id  : 999,
            current : 0,
        };
        0x2::transfer::transfer<AeonCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun mint(arg0: &mut AeonCap, arg1: &mut 0x141d8a2333f9369452fe075331924bb98d2abf0ee98de941db85aaf809c4ef54::distribution::Distribution, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u16, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.current == arg5, 2);
        assert!(arg0.current <= arg0.max_id, 3);
        let v0 = pad_to_three_digits(arg0.current);
        0x1::string::append(&mut v0, 0x1::string::utf8(b".sui"));
        let v1 = Aeon{
            id      : 0x2::object::new(arg6),
            image   : arg2,
            club_id : arg0.current,
            name_id : pad_to_three_digits(arg0.current),
            color   : arg3,
            theme   : arg4,
        };
        0x141d8a2333f9369452fe075331924bb98d2abf0ee98de941db85aaf809c4ef54::distribution::add_nft<Aeon>(arg1, 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::new(v0), v1, true);
        arg0.current = arg0.current + 1;
    }

    public(friend) fun pad_to_three_digits(arg0: u16) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"");
        if (arg0 < 10) {
            0x1::string::append(&mut v0, 0x1::string::utf8(b"00"));
            0x1::string::append(&mut v0, 0x1::u16::to_string(arg0));
            v0
        } else if (arg0 < 100) {
            0x1::string::append(&mut v0, 0x1::string::utf8(b"0"));
            0x1::string::append(&mut v0, 0x1::u16::to_string(arg0));
            v0
        } else {
            0x1::u16::to_string(arg0)
        }
    }

    // decompiled from Move bytecode v6
}

