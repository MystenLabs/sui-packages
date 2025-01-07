module 0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::config {
    struct BucketPointPhase1 has drop {
        dummy_field: bool,
    }

    struct BucketPointConfig has key {
        id: 0x2::object::UID,
        weights: 0x2::vec_map::VecMap<0x2::object::ID, 0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::float::Float>,
        actions: 0x2::vec_map::VecMap<0x2::object::ID, 0x1::ascii::String>,
        valid_versions: 0x2::vec_set::VecSet<u64>,
    }

    struct BucketPointCap has key {
        id: 0x2::object::UID,
    }

    public(friend) fun insert(arg0: &mut BucketPointConfig, arg1: 0x2::object::ID, arg2: u64, arg3: 0x1::ascii::String) {
        0x2::vec_map::insert<0x2::object::ID, 0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::float::Float>(&mut arg0.weights, arg1, 0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::float::from_percent_u64(arg2));
        0x2::vec_map::insert<0x2::object::ID, 0x1::ascii::String>(&mut arg0.actions, arg1, arg3);
    }

    public fun add_point(arg0: &BucketPointCap, arg1: address, arg2: 0x1::ascii::String, arg3: u256, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = witness();
        0xb5b6c91d3161c1fc27075339dbe8afafef5f85f6762157be484ed49583f7ef53::point::send_add_point_req_with_owner<BucketPointPhase1>(&v0, arg1, arg2, arg3, arg4);
    }

    public fun add_version(arg0: &mut BucketPointConfig, arg1: &BucketPointCap, arg2: u64) {
        0x2::vec_set::insert<u64>(&mut arg0.valid_versions, arg2);
    }

    public(friend) fun assert_valid_config_version(arg0: &BucketPointConfig) {
        let v0 = package_version();
        if (!0x2::vec_set::contains<u64>(&arg0.valid_versions, &v0)) {
            err_invalid_package_version();
        };
    }

    public fun duration() : u64 {
        3600000
    }

    fun err_invalid_package_version() {
        abort 0
    }

    public fun get_locker_params<T0: store, T1: drop>(arg0: &BucketPointConfig, arg1: &0x60edcdd61727c06b94e0e9e5b034240d3c905d00a82ffb06b63d9aedbac2c5a0::asset_locker::AssetLocker<T0, T1>) : (0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::float::Float, 0x1::ascii::String) {
        let v0 = 0x2::object::id<0x60edcdd61727c06b94e0e9e5b034240d3c905d00a82ffb06b63d9aedbac2c5a0::asset_locker::AssetLocker<T0, T1>>(arg1);
        let v1 = &v0;
        (*0x2::vec_map::get<0x2::object::ID, 0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::float::Float>(&arg0.weights, v1), *0x2::vec_map::get<0x2::object::ID, 0x1::ascii::String>(&arg0.actions, v1))
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = BucketPointConfig{
            id             : 0x2::object::new(arg0),
            weights        : 0x2::vec_map::empty<0x2::object::ID, 0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::float::Float>(),
            actions        : 0x2::vec_map::empty<0x2::object::ID, 0x1::ascii::String>(),
            valid_versions : 0x2::vec_set::singleton<u64>(package_version()),
        };
        0x2::transfer::share_object<BucketPointConfig>(v0);
        let v1 = BucketPointCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<BucketPointCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun package_version() : u64 {
        1
    }

    public fun remove_version(arg0: &mut BucketPointConfig, arg1: &BucketPointCap, arg2: u64) {
        0x2::vec_set::remove<u64>(&mut arg0.valid_versions, &arg2);
    }

    public fun update_locker_weight(arg0: &mut BucketPointConfig, arg1: &BucketPointCap, arg2: 0x2::object::ID, arg3: u64) {
        let (_, _) = 0x2::vec_map::remove<0x2::object::ID, 0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::float::Float>(&mut arg0.weights, &arg2);
        0x2::vec_map::insert<0x2::object::ID, 0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::float::Float>(&mut arg0.weights, arg2, 0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::float::from_percent_u64(arg3));
    }

    public(friend) fun witness() : BucketPointPhase1 {
        BucketPointPhase1{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

