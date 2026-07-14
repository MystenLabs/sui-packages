module 0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::seal_policy {
    fun assert_id_binds_character(arg0: &vector<u8>, arg1: &0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter) {
        assert!(0x1::vector::length<u8>(arg0) >= 32, 6);
        let v0 = 0x2::object::id<0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter>(arg1);
        let v1 = 0x2::bcs::to_bytes<0x2::object::ID>(&v0);
        let v2 = 0;
        while (v2 < 32) {
            assert!(*0x1::vector::borrow<u8>(arg0, v2) == *0x1::vector::borrow<u8>(&v1, v2), 0);
            v2 = v2 + 1;
        };
    }

    entry fun seal_approve(arg0: vector<u8>, arg1: &0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter, arg2: &0x2::tx_context::TxContext) {
        assert_id_binds_character(&arg0, arg1);
        assert!(0x2::tx_context::sender(arg2) == 0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::owner(arg1), 1);
    }

    entry fun seal_approve_guardian(arg0: vector<u8>, arg1: &0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter, arg2: &0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::guardian::GuardianSet, arg3: &0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::guardian::RecoveryRequest, arg4: &0x2::tx_context::TxContext) {
        assert_id_binds_character(&arg0, arg1);
        let v0 = 0x2::object::id<0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter>(arg1);
        assert!(0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::guardian::guardian_set_character_id(arg2) == v0, 2);
        assert!(0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::guardian::recovery_request_character_id(arg3) == v0, 2);
        assert!(!0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::guardian::recovery_request_disputed(arg3), 4);
        assert!(0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::guardian::recovery_request_finalized(arg3), 3);
        assert!(0x2::tx_context::sender(arg4) == 0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::guardian::recovery_request_proposed_owner(arg3), 5);
    }

    // decompiled from Move bytecode v7
}

