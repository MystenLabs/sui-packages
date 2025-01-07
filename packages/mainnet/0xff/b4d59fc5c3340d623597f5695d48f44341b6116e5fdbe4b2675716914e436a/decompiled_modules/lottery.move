module 0xffb4d59fc5c3340d623597f5695d48f44341b6116e5fdbe4b2675716914e436a::lottery {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Lottery has key {
        id: 0x2::object::UID,
        round: u64,
        draw_ts: u64,
        winning_ticket: 0x1::option::Option<u64>,
    }

    public entry fun new(arg0: &AdminCap, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Lottery{
            id             : 0x2::object::new(arg3),
            round          : arg1,
            draw_ts        : arg2,
            winning_ticket : 0x1::option::none<u64>(),
        };
        0x2::transfer::share_object<Lottery>(v0);
    }

    public entry fun complete(arg0: &mut Lottery, arg1: &mut 0xffb4d59fc5c3340d623597f5695d48f44341b6116e5fdbe4b2675716914e436a::sequence_number::Registry, arg2: vector<u8>, arg3: vector<u8>, arg4: &0x2::clock::Clock) {
        assert!(0x2::clock::timestamp_ms(arg4) >= arg0.draw_ts, 0);
        assert!(0x1::option::is_none<u64>(&arg0.winning_ticket), 1);
        let v0 = 0x2::object::uid_to_address(&arg0.id);
        0xffb4d59fc5c3340d623597f5695d48f44341b6116e5fdbe4b2675716914e436a::drand::verify_drand_signature(arg2, arg3, arg0.round);
        0xffb4d59fc5c3340d623597f5695d48f44341b6116e5fdbe4b2675716914e436a::sequence_number::confirm_participation(arg1, v0);
        let (v1, v2) = 0xffb4d59fc5c3340d623597f5695d48f44341b6116e5fdbe4b2675716914e436a::sequence_number::get_lottery_range(arg1, v0);
        let v3 = 0xffb4d59fc5c3340d623597f5695d48f44341b6116e5fdbe4b2675716914e436a::drand::derive_randomness(arg2);
        arg0.winning_ticket = 0x1::option::some<u64>(v1 + 0xffb4d59fc5c3340d623597f5695d48f44341b6116e5fdbe4b2675716914e436a::drand::safe_selection(v2 - v1, &v3));
    }

    public fun get_winning_ticket(arg0: &Lottery) : 0x1::option::Option<u64> {
        arg0.winning_ticket
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

