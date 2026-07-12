module 0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::fiat_hold {
    struct HeldTranche has copy, drop, store {
        provider_tag: vector<u8>,
        contribution_ref: vector<u8>,
        amount_mist: u64,
        unlock_epoch_ms: u64,
        dispute_open: bool,
    }

    struct FiatHoldLedger has store, key {
        id: 0x2::object::UID,
        character_id: 0x2::object::ID,
        tranches: vector<HeldTranche>,
    }

    struct FiatHoldLedgerCreated has copy, drop {
        ledger_id: 0x2::object::ID,
        character_id: 0x2::object::ID,
    }

    struct TrancheRecorded has copy, drop {
        ledger_id: 0x2::object::ID,
        character_id: 0x2::object::ID,
        provider_tag: vector<u8>,
        contribution_ref: vector<u8>,
        amount_mist: u64,
        unlock_epoch_ms: u64,
    }

    struct TrancheDisputeChanged has copy, drop {
        ledger_id: 0x2::object::ID,
        contribution_ref: vector<u8>,
        dispute_open: bool,
    }

    struct TrancheClawedBack has copy, drop {
        ledger_id: 0x2::object::ID,
        contribution_ref: vector<u8>,
        clawed_mist: u64,
        remaining_mist: u64,
    }

    fun assert_ref(arg0: &vector<u8>) {
        assert!(0x1::vector::length<u8>(arg0) <= 128, 705);
    }

    public entry fun clawback_consume(arg0: &0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter, arg1: &mut FiatHoldLedger, arg2: vector<u8>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::assert_owner(arg0, 0x2::tx_context::sender(arg4));
        assert!(arg1.character_id == 0x2::object::id<0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter>(arg0), 700);
        let v0 = 0x1::vector::borrow_mut<HeldTranche>(&mut arg1.tranches, find_tranche(arg1, &arg2));
        assert!(arg3 <= v0.amount_mist, 704);
        v0.amount_mist = v0.amount_mist - arg3;
        if (v0.amount_mist == 0) {
            v0.dispute_open = false;
        };
        let v1 = TrancheClawedBack{
            ledger_id        : 0x2::object::uid_to_inner(&arg1.id),
            contribution_ref : arg2,
            clawed_mist      : arg3,
            remaining_mist   : v0.amount_mist,
        };
        0x2::event::emit<TrancheClawedBack>(v1);
    }

    public entry fun create_ledger(arg0: &0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter, arg1: &mut 0x2::tx_context::TxContext) {
        0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::assert_owner(arg0, 0x2::tx_context::sender(arg1));
        let v0 = FiatHoldLedger{
            id           : 0x2::object::new(arg1),
            character_id : 0x2::object::id<0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter>(arg0),
            tranches     : 0x1::vector::empty<HeldTranche>(),
        };
        let v1 = FiatHoldLedgerCreated{
            ledger_id    : 0x2::object::uid_to_inner(&v0.id),
            character_id : 0x2::object::id<0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter>(arg0),
        };
        0x2::event::emit<FiatHoldLedgerCreated>(v1);
        0x2::transfer::share_object<FiatHoldLedger>(v0);
    }

    fun find_tranche(arg0: &FiatHoldLedger, arg1: &vector<u8>) : u64 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<HeldTranche>(&arg0.tranches)) {
            if (&0x1::vector::borrow<HeldTranche>(&arg0.tranches, v0).contribution_ref == arg1) {
                return v0
            };
            v0 = v0 + 1;
        };
        abort 703
    }

    public fun held_floor_mist(arg0: &FiatHoldLedger, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<HeldTranche>(&arg0.tranches)) {
            let v2 = 0x1::vector::borrow<HeldTranche>(&arg0.tranches, v1);
            if (v2.dispute_open || 0x2::clock::timestamp_ms(arg1) < v2.unlock_epoch_ms) {
                v0 = v0 + v2.amount_mist;
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun ledger_character_id(arg0: &FiatHoldLedger) : 0x2::object::ID {
        arg0.character_id
    }

    public fun outstanding_for_provider(arg0: &FiatHoldLedger, arg1: vector<u8>, arg2: &0x2::clock::Clock) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<HeldTranche>(&arg0.tranches)) {
            let v2 = 0x1::vector::borrow<HeldTranche>(&arg0.tranches, v1);
            let v3 = if (v2.dispute_open || 0x2::clock::timestamp_ms(arg2) < v2.unlock_epoch_ms) {
                if (v2.amount_mist > 0) {
                    &v2.provider_tag == &arg1
                } else {
                    false
                }
            } else {
                false
            };
            if (v3) {
                v0 = v0 + 1;
            };
            v1 = v1 + 1;
        };
        v0
    }

    public entry fun record_tranche(arg0: &0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter, arg1: &mut FiatHoldLedger, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::assert_owner(arg0, 0x2::tx_context::sender(arg6));
        assert!(arg1.character_id == 0x2::object::id<0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter>(arg0), 700);
        assert!(arg4 > 0, 702);
        assert_ref(&arg2);
        assert_ref(&arg3);
        let v0 = HeldTranche{
            provider_tag     : arg2,
            contribution_ref : arg3,
            amount_mist      : arg4,
            unlock_epoch_ms  : arg5,
            dispute_open     : false,
        };
        0x1::vector::push_back<HeldTranche>(&mut arg1.tranches, v0);
        let v1 = TrancheRecorded{
            ledger_id        : 0x2::object::uid_to_inner(&arg1.id),
            character_id     : arg1.character_id,
            provider_tag     : arg2,
            contribution_ref : arg3,
            amount_mist      : arg4,
            unlock_epoch_ms  : arg5,
        };
        0x2::event::emit<TrancheRecorded>(v1);
    }

    public entry fun set_dispute(arg0: &0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter, arg1: &mut FiatHoldLedger, arg2: vector<u8>, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::assert_owner(arg0, 0x2::tx_context::sender(arg4));
        assert!(arg1.character_id == 0x2::object::id<0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter>(arg0), 700);
        0x1::vector::borrow_mut<HeldTranche>(&mut arg1.tranches, find_tranche(arg1, &arg2)).dispute_open = arg3;
        let v0 = TrancheDisputeChanged{
            ledger_id        : 0x2::object::uid_to_inner(&arg1.id),
            contribution_ref : arg2,
            dispute_open     : arg3,
        };
        0x2::event::emit<TrancheDisputeChanged>(v0);
    }

    public fun tranche_count(arg0: &FiatHoldLedger) : u64 {
        0x1::vector::length<HeldTranche>(&arg0.tranches)
    }

    // decompiled from Move bytecode v7
}

