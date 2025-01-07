module 0xca91762b938ab57cc93ddf00858c4ef5e8fec0faa70b3798bf2da915ebcb7ba4::task5 {
    struct PlayEvent has copy, drop {
        user_input: u8,
        random_number: u8,
        result: 0x1::string::String,
    }

    fun get_random_number(arg0: &0x2::clock::Clock) : u8 {
        ((0x2::clock::timestamp_ms(arg0) % 3) as u8) + 1
    }

    public entry fun mora(arg0: &0x2::clock::Clock, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 >= 1 && arg1 <= 3, 0);
        let v0 = get_random_number(arg0);
        if (arg1 == v0) {
            let v1 = PlayEvent{
                user_input    : arg1,
                random_number : v0,
                result        : 0x1::string::utf8(b"You win. My github id is qpb8023"),
            };
            0x2::event::emit<PlayEvent>(v1);
        } else {
            let v2 = PlayEvent{
                user_input    : arg1,
                random_number : v0,
                result        : 0x1::string::utf8(b"You lose."),
            };
            0x2::event::emit<PlayEvent>(v2);
        };
    }

    // decompiled from Move bytecode v6
}

