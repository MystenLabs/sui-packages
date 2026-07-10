module 0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::wallets {
    struct ContributionWalletSet has store, key {
        id: 0x2::object::UID,
        character_id: 0x2::object::ID,
        owner: address,
        chain_namespace: 0x1::string::String,
        storage_renewal_wallet: 0x1::string::String,
        inference_runtime_wallet: 0x1::string::String,
        treasury_endowment_wallet: 0x1::string::String,
        schema_version: u64,
        nonce: u64,
        created_at_ms: u64,
        updated_at_ms: u64,
    }

    struct ContributionWalletSetCreated has copy, drop {
        wallet_set_id: 0x2::object::ID,
        character_id: 0x2::object::ID,
        owner: address,
        chain_namespace: 0x1::string::String,
        storage_renewal_wallet: 0x1::string::String,
        inference_runtime_wallet: 0x1::string::String,
        treasury_endowment_wallet: 0x1::string::String,
        timestamp_ms: u64,
    }

    struct ContributionWalletSetUpdated has copy, drop {
        wallet_set_id: 0x2::object::ID,
        character_id: 0x2::object::ID,
        owner: address,
        chain_namespace: 0x1::string::String,
        nonce: u64,
        timestamp_ms: u64,
    }

    fun assert_owner(arg0: &0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter, arg1: address) {
        0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::assert_owner(arg0, arg1);
    }

    fun assert_ref(arg0: &vector<u8>) {
        assert!(0x1::vector::length<u8>(arg0) > 0, 302);
        assert!(0x1::vector::length<u8>(arg0) <= 512, 303);
    }

    fun assert_three_wallet_args(arg0: &vector<u8>, arg1: &vector<u8>, arg2: &vector<u8>, arg3: &vector<u8>) {
        assert_ref(arg0);
        assert_ref(arg1);
        assert_ref(arg2);
        assert_ref(arg3);
    }

    fun assert_wallet_set_owner(arg0: &0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter, arg1: &ContributionWalletSet, arg2: address) {
        assert_owner(arg0, arg2);
        assert!(arg1.owner == arg2, 300);
        assert!(arg1.character_id == 0x2::object::id<0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter>(arg0), 301);
    }

    entry fun create_contribution_wallet_set(arg0: &0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert_owner(arg0, 0x2::tx_context::sender(arg6));
        0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::assert_not_paused(arg0);
        assert_three_wallet_args(&arg1, &arg2, &arg3, &arg4);
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = ContributionWalletSet{
            id                        : 0x2::object::new(arg6),
            character_id              : 0x2::object::id<0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter>(arg0),
            owner                     : 0x2::tx_context::sender(arg6),
            chain_namespace           : 0x1::string::utf8(arg1),
            storage_renewal_wallet    : 0x1::string::utf8(arg2),
            inference_runtime_wallet  : 0x1::string::utf8(arg3),
            treasury_endowment_wallet : 0x1::string::utf8(arg4),
            schema_version            : 1,
            nonce                     : 0,
            created_at_ms             : v0,
            updated_at_ms             : v0,
        };
        let v2 = ContributionWalletSetCreated{
            wallet_set_id             : 0x2::object::uid_to_inner(&v1.id),
            character_id              : 0x2::object::id<0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter>(arg0),
            owner                     : 0x2::tx_context::sender(arg6),
            chain_namespace           : v1.chain_namespace,
            storage_renewal_wallet    : v1.storage_renewal_wallet,
            inference_runtime_wallet  : v1.inference_runtime_wallet,
            treasury_endowment_wallet : v1.treasury_endowment_wallet,
            timestamp_ms              : v0,
        };
        0x2::event::emit<ContributionWalletSetCreated>(v2);
        0x2::transfer::public_transfer<ContributionWalletSet>(v1, 0x2::tx_context::sender(arg6));
    }

    entry fun update_contribution_wallet_set(arg0: &0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter, arg1: &mut ContributionWalletSet, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        assert_wallet_set_owner(arg0, arg1, 0x2::tx_context::sender(arg7));
        0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::assert_not_paused(arg0);
        assert_three_wallet_args(&arg2, &arg3, &arg4, &arg5);
        arg1.chain_namespace = 0x1::string::utf8(arg2);
        arg1.storage_renewal_wallet = 0x1::string::utf8(arg3);
        arg1.inference_runtime_wallet = 0x1::string::utf8(arg4);
        arg1.treasury_endowment_wallet = 0x1::string::utf8(arg5);
        arg1.nonce = arg1.nonce + 1;
        arg1.updated_at_ms = 0x2::clock::timestamp_ms(arg6);
        let v0 = ContributionWalletSetUpdated{
            wallet_set_id   : 0x2::object::uid_to_inner(&arg1.id),
            character_id    : 0x2::object::id<0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter>(arg0),
            owner           : 0x2::tx_context::sender(arg7),
            chain_namespace : arg1.chain_namespace,
            nonce           : arg1.nonce,
            timestamp_ms    : arg1.updated_at_ms,
        };
        0x2::event::emit<ContributionWalletSetUpdated>(v0);
    }

    public fun wallet_set_character_id(arg0: &ContributionWalletSet) : 0x2::object::ID {
        arg0.character_id
    }

    public fun wallet_set_nonce(arg0: &ContributionWalletSet) : u64 {
        arg0.nonce
    }

    public fun wallet_set_owner(arg0: &ContributionWalletSet) : address {
        arg0.owner
    }

    // decompiled from Move bytecode v7
}

