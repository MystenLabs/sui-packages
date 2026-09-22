module 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::protocol {
    struct Protocol has key {
        id: 0x2::object::UID,
        generation: 0x247b6e2f000a77e82f4afc5c08f95f746e2e132ba2e1ecb3a9082f0c41ab80e2::operational_version::OperationalVersion<0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::blast_boosts_aftermath::BLAST_BOOSTS_AFTERMATH>,
    }

    fun new(arg0: &mut 0x2::tx_context::TxContext) : Protocol {
        Protocol{
            id         : 0x2::object::new(arg0),
            generation : 0x247b6e2f000a77e82f4afc5c08f95f746e2e132ba2e1ecb3a9082f0c41ab80e2::operational_version::new<0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::blast_boosts_aftermath::BLAST_BOOSTS_AFTERMATH>(),
        }
    }

    public(friend) fun advance(arg0: &mut Protocol) {
        0x247b6e2f000a77e82f4afc5c08f95f746e2e132ba2e1ecb3a9082f0c41ab80e2::operational_version::advance<0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::blast_boosts_aftermath::BLAST_BOOSTS_AFTERMATH>(&mut arg0.generation, 0x2::object::uid_to_inner(&arg0.id), 2);
    }

    public(friend) fun assert_current(arg0: &Protocol) {
        0x247b6e2f000a77e82f4afc5c08f95f746e2e132ba2e1ecb3a9082f0c41ab80e2::operational_version::assert_current<0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::blast_boosts_aftermath::BLAST_BOOSTS_AFTERMATH>(&arg0.generation, 1);
    }

    public(friend) fun assert_next(arg0: &Protocol) {
        0x247b6e2f000a77e82f4afc5c08f95f746e2e132ba2e1ecb3a9082f0c41ab80e2::operational_version::assert_next<0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::blast_boosts_aftermath::BLAST_BOOSTS_AFTERMATH>(&arg0.generation, 2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<Protocol>(new(arg0));
    }

    // decompiled from Move bytecode v7
}

