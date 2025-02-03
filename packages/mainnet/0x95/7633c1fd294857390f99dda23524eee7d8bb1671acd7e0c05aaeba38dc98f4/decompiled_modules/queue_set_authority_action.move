module 0x957633c1fd294857390f99dda23524eee7d8bb1671acd7e0c05aaeba38dc98f4::queue_set_authority_action {
    struct QueueAuthorityUpdated has copy, drop {
        queue_id: 0x2::object::ID,
        existing_authority: address,
        new_authority: address,
    }

    fun actuate(arg0: &mut 0x957633c1fd294857390f99dda23524eee7d8bb1671acd7e0c05aaeba38dc98f4::queue::Queue, arg1: address) {
        let v0 = QueueAuthorityUpdated{
            queue_id           : 0x957633c1fd294857390f99dda23524eee7d8bb1671acd7e0c05aaeba38dc98f4::queue::id(arg0),
            existing_authority : 0x957633c1fd294857390f99dda23524eee7d8bb1671acd7e0c05aaeba38dc98f4::queue::authority(arg0),
            new_authority      : arg1,
        };
        0x957633c1fd294857390f99dda23524eee7d8bb1671acd7e0c05aaeba38dc98f4::queue::set_authority(arg0, arg1);
        0x2::event::emit<QueueAuthorityUpdated>(v0);
    }

    public entry fun run(arg0: &mut 0x957633c1fd294857390f99dda23524eee7d8bb1671acd7e0c05aaeba38dc98f4::queue::Queue, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        validate(arg0, arg2);
        actuate(arg0, arg1);
    }

    public fun validate(arg0: &0x957633c1fd294857390f99dda23524eee7d8bb1671acd7e0c05aaeba38dc98f4::queue::Queue, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x957633c1fd294857390f99dda23524eee7d8bb1671acd7e0c05aaeba38dc98f4::queue::has_authority(arg0, arg1), 9223372118459154433);
    }

    // decompiled from Move bytecode v6
}

