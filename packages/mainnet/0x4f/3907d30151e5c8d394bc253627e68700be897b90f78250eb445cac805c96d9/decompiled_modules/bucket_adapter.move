module 0x4f3907d30151e5c8d394bc253627e68700be897b90f78250eb445cac805c96d9::bucket_adapter {
    struct BucketAdapterRegistry has key {
        id: 0x2::object::UID,
        map: 0x2::vec_map::VecMap<0x2::object::ID, 0x2::object::ID>,
        whitelist: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
    }

    struct BucketAdapterAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct BucketVault has key {
        id: 0x2::object::UID,
        main_vault_id: 0x1::option::Option<0x2::object::ID>,
        stake_proof: 0x1::option::Option<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>,
        record: BucketRecord,
        is_redeeming: bool,
    }

    struct BucketRecord has store {
        collateral: 0x2::vec_map::VecMap<0x1::ascii::String, u64>,
        deposit: 0x2::vec_map::VecMap<0x1::ascii::String, u64>,
        borrow: u64,
        reward: 0x2::vec_map::VecMap<0x1::ascii::String, u64>,
    }

    struct BucketState {
        collateral: 0x2::vec_map::VecMap<0x1::ascii::String, u64>,
        borrow: u64,
        deposit: 0x2::vec_map::VecMap<0x1::ascii::String, u64>,
        reward: 0x2::vec_map::VecMap<0x1::ascii::String, u64>,
    }

    struct Bucket has drop {
        dummy_field: bool,
    }

    fun err_already_registered() {
        abort 103
    }

    fun err_less_than_bucket_state_collateral() {
        abort 105
    }

    fun err_less_than_bucket_state_deposit() {
        abort 108
    }

    fun err_main_vault_id_not_matched() {
        abort 100
    }

    fun err_more_than_bucket_state_borrow() {
        abort 107
    }

    fun err_not_redeeming() {
        abort 110
    }

    fun err_not_whitelisted_source() {
        abort 104
    }

    fun err_redeeming() {
        abort 109
    }

    fun err_stake_proof_existed() {
        abort 101
    }

    fun err_stake_proof_not_existed() {
        abort 102
    }

    fun err_still_existed_reward() {
        abort 106
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = BucketAdapterRegistry{
            id        : 0x2::object::new(arg0),
            map       : 0x2::vec_map::empty<0x2::object::ID, 0x2::object::ID>(),
            whitelist : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
        };
        let v1 = BucketAdapterAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<BucketAdapterRegistry>(v0);
        0x2::transfer::public_transfer<BucketAdapterAdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

