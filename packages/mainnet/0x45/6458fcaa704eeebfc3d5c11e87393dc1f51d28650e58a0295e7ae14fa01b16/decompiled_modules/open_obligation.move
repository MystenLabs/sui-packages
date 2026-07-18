module 0x456458fcaa704eeebfc3d5c11e87393dc1f51d28650e58a0295e7ae14fa01b16::open_obligation {
    struct ObligationHotPotato {
        obligation_id: 0x2::object::ID,
    }

    struct ObligationCreatedEvent has copy, drop {
        sender: address,
        obligation: 0x2::object::ID,
        obligation_key: 0x2::object::ID,
    }

    public fun open_obligation(arg0: &0x456458fcaa704eeebfc3d5c11e87393dc1f51d28650e58a0295e7ae14fa01b16::version::Version, arg1: &mut 0x2::tx_context::TxContext) : (0x456458fcaa704eeebfc3d5c11e87393dc1f51d28650e58a0295e7ae14fa01b16::obligation::Obligation, 0x456458fcaa704eeebfc3d5c11e87393dc1f51d28650e58a0295e7ae14fa01b16::obligation::ObligationKey, ObligationHotPotato) {
        0x456458fcaa704eeebfc3d5c11e87393dc1f51d28650e58a0295e7ae14fa01b16::version::assert_current_version(arg0);
        let (v0, v1) = create_obligation(arg1);
        let v2 = v0;
        let v3 = ObligationHotPotato{obligation_id: 0x2::object::id<0x456458fcaa704eeebfc3d5c11e87393dc1f51d28650e58a0295e7ae14fa01b16::obligation::Obligation>(&v2)};
        (v2, v1, v3)
    }

    fun create_obligation(arg0: &mut 0x2::tx_context::TxContext) : (0x456458fcaa704eeebfc3d5c11e87393dc1f51d28650e58a0295e7ae14fa01b16::obligation::Obligation, 0x456458fcaa704eeebfc3d5c11e87393dc1f51d28650e58a0295e7ae14fa01b16::obligation::ObligationKey) {
        let (v0, v1) = 0x456458fcaa704eeebfc3d5c11e87393dc1f51d28650e58a0295e7ae14fa01b16::obligation::new(arg0);
        let v2 = v1;
        let v3 = v0;
        let v4 = ObligationCreatedEvent{
            sender         : 0x2::tx_context::sender(arg0),
            obligation     : 0x2::object::id<0x456458fcaa704eeebfc3d5c11e87393dc1f51d28650e58a0295e7ae14fa01b16::obligation::Obligation>(&v3),
            obligation_key : 0x2::object::id<0x456458fcaa704eeebfc3d5c11e87393dc1f51d28650e58a0295e7ae14fa01b16::obligation::ObligationKey>(&v2),
        };
        0x2::event::emit<ObligationCreatedEvent>(v4);
        (v3, v2)
    }

    public entry fun open_obligation_entry(arg0: &0x456458fcaa704eeebfc3d5c11e87393dc1f51d28650e58a0295e7ae14fa01b16::version::Version, arg1: &mut 0x2::tx_context::TxContext) {
        0x456458fcaa704eeebfc3d5c11e87393dc1f51d28650e58a0295e7ae14fa01b16::version::assert_current_version(arg0);
        let (v0, v1) = create_obligation(arg1);
        0x2::transfer::public_transfer<0x456458fcaa704eeebfc3d5c11e87393dc1f51d28650e58a0295e7ae14fa01b16::obligation::ObligationKey>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x456458fcaa704eeebfc3d5c11e87393dc1f51d28650e58a0295e7ae14fa01b16::obligation::Obligation>(v0);
    }

    public fun return_obligation(arg0: &0x456458fcaa704eeebfc3d5c11e87393dc1f51d28650e58a0295e7ae14fa01b16::version::Version, arg1: 0x456458fcaa704eeebfc3d5c11e87393dc1f51d28650e58a0295e7ae14fa01b16::obligation::Obligation, arg2: ObligationHotPotato) {
        0x456458fcaa704eeebfc3d5c11e87393dc1f51d28650e58a0295e7ae14fa01b16::version::assert_current_version(arg0);
        let ObligationHotPotato { obligation_id: v0 } = arg2;
        assert!(v0 == 0x2::object::id<0x456458fcaa704eeebfc3d5c11e87393dc1f51d28650e58a0295e7ae14fa01b16::obligation::Obligation>(&arg1), 0x456458fcaa704eeebfc3d5c11e87393dc1f51d28650e58a0295e7ae14fa01b16::error::invalid_obligation_error());
        0x2::transfer::public_share_object<0x456458fcaa704eeebfc3d5c11e87393dc1f51d28650e58a0295e7ae14fa01b16::obligation::Obligation>(arg1);
    }

    // decompiled from Move bytecode v7
}

