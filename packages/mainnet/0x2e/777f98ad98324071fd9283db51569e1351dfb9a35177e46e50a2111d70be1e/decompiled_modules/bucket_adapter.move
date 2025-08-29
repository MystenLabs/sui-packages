module 0x2e777f98ad98324071fd9283db51569e1351dfb9a35177e46e50a2111d70be1e::bucket_adapter {
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

    public fun new<T0: drop>(arg0: &mut BucketAdapterRegistry, arg1: 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::Message<T0, Bucket>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.whitelist, &v0)) {
            err_not_whitelisted_source();
        };
        let v1 = stamp();
        let v2 = 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::burn_and_get_info<T0, Bucket>(arg1, &v1);
        let v3 = 0x2::bag::remove<vector<u8>, 0x2::object::ID>(&mut v2, b"main_vault_id");
        0x2::bag::destroy_empty(v2);
        if (0x2::vec_map::contains<0x2::object::ID, 0x2::object::ID>(&arg0.map, &v3)) {
            err_already_registered();
        };
        let v4 = BucketRecord{
            collateral : 0x2::vec_map::empty<0x1::ascii::String, u64>(),
            deposit    : 0x2::vec_map::empty<0x1::ascii::String, u64>(),
            borrow     : 0,
            reward     : 0x2::vec_map::empty<0x1::ascii::String, u64>(),
        };
        let v5 = BucketVault{
            id            : 0x2::object::new(arg2),
            main_vault_id : 0x1::option::some<0x2::object::ID>(v3),
            stake_proof   : 0x1::option::none<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>(),
            record        : v4,
            is_redeeming  : false,
        };
        0x2::vec_map::insert<0x2::object::ID, 0x2::object::ID>(&mut arg0.map, v3, *0x2::object::uid_as_inner(&v5.id));
        0x2::transfer::share_object<BucketVault>(v5);
    }

    entry fun add_whitelist<T0>(arg0: &mut BucketAdapterRegistry, arg1: &BucketAdapterAdminCap) {
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.whitelist, 0x1::type_name::get<T0>());
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

    entry fun remove_whitelist<T0>(arg0: &mut BucketAdapterRegistry, arg1: &BucketAdapterAdminCap) {
        let v0 = 0x1::type_name::get<T0>();
        0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg0.whitelist, &v0);
    }

    fun stamp() : Bucket {
        Bucket{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

