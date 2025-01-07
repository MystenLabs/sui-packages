module 0xe8efe3c804dffe005f336e5b87ae3c21c7b23fa63f29bcc7cdfb90fa506126f1::dapp_score {
    struct DappScoreManagement has store, key {
        id: 0x2::object::UID,
        admins: vector<address>,
        creator: address,
        score_object_exist: 0x2::table::Table<vector<u8>, bool>,
    }

    struct UpdatorConfig has store, key {
        id: 0x2::object::UID,
        updator: address,
    }

    struct UserDappScore has store, key {
        id: 0x2::object::UID,
        user: address,
        dapp: address,
        target: 0x1::string::String,
        score: u256,
    }

    struct DappTargetConfig has store, key {
        id: 0x2::object::UID,
        dapp: address,
        target: 0x1::string::String,
        display_name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        admins: vector<address>,
    }

    struct DappScoreUpadteRequest has store, key {
        id: 0x2::object::UID,
        user: address,
        dapp: address,
        target: 0x1::string::String,
        proof: vector<u8>,
    }

    public fun add_admin(arg0: &mut DappScoreManagement, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(is_admin(arg0, &v0), 1);
        0x1::vector::push_back<address>(&mut arg0.admins, arg1);
    }

    public fun add_dapp_target_admin(arg0: &mut DappTargetConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x1::vector::contains<address>(&arg0.admins, &v0), 1);
        0x1::vector::push_back<address>(&mut arg0.admins, arg1);
    }

    public fun add_updator(arg0: &DappScoreManagement, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(is_admin(arg0, &v0), 1);
        let v1 = UpdatorConfig{
            id      : 0x2::object::new(arg2),
            updator : arg1,
        };
        0x2::transfer::public_share_object<UpdatorConfig>(v1);
    }

    public fun change_updator(arg0: &DappScoreManagement, arg1: &mut UpdatorConfig, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(is_admin(arg0, &v0), 1);
        arg1.updator = arg2;
    }

    public fun create_dapp_score_update_request(arg0: &UpdatorConfig, arg1: address, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = DappScoreUpadteRequest{
            id     : 0x2::object::new(arg4),
            user   : 0x2::tx_context::sender(arg4),
            dapp   : arg1,
            target : 0x1::string::utf8(arg2),
            proof  : arg3,
        };
        0x2::transfer::public_transfer<DappScoreUpadteRequest>(v0, arg0.updator);
    }

    public fun create_dapp_target_config(arg0: address, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v0, 0x2::tx_context::sender(arg5));
        let v1 = DappTargetConfig{
            id           : 0x2::object::new(arg5),
            dapp         : arg0,
            target       : 0x1::string::utf8(arg1),
            display_name : 0x1::string::utf8(arg2),
            description  : 0x1::string::utf8(arg3),
            image_url    : 0x1::string::utf8(arg4),
            admins       : v0,
        };
        0x2::transfer::public_share_object<DappTargetConfig>(v1);
    }

    public fun get_dapp(arg0: &UserDappScore) : address {
        arg0.dapp
    }

    public fun get_score(arg0: &UserDappScore) : u256 {
        arg0.score
    }

    public fun get_target(arg0: &UserDappScore) : 0x1::string::String {
        arg0.target
    }

    public fun get_user(arg0: &UserDappScore) : address {
        arg0.user
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v0, 0x2::tx_context::sender(arg0));
        let v1 = DappScoreManagement{
            id                 : 0x2::object::new(arg0),
            admins             : v0,
            creator            : 0x2::tx_context::sender(arg0),
            score_object_exist : 0x2::table::new<vector<u8>, bool>(arg0),
        };
        0x2::transfer::share_object<DappScoreManagement>(v1);
    }

    public fun is_admin(arg0: &DappScoreManagement, arg1: &address) : bool {
        0x1::vector::contains<address>(&arg0.admins, arg1)
    }

    public fun new_dapp_score_object(arg0: &UpdatorConfig, arg1: &mut DappScoreManagement, arg2: DappScoreUpadteRequest, arg3: u256, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.updator, 1);
        let DappScoreUpadteRequest {
            id     : v0,
            user   : v1,
            dapp   : v2,
            target : v3,
            proof  : _,
        } = arg2;
        let v5 = v3;
        let v6 = v2;
        let v7 = v1;
        0x2::object::delete(v0);
        let v8 = 0x2::bcs::to_bytes<address>(&v7);
        0x1::vector::append<u8>(&mut v8, 0x2::bcs::to_bytes<address>(&v6));
        0x1::vector::append<u8>(&mut v8, 0x2::bcs::to_bytes<0x1::string::String>(&v5));
        assert!(!0x2::table::contains<vector<u8>, bool>(&arg1.score_object_exist, v8), 2);
        0x2::table::add<vector<u8>, bool>(&mut arg1.score_object_exist, v8, true);
        let v9 = UserDappScore{
            id     : 0x2::object::new(arg4),
            user   : v7,
            dapp   : v6,
            target : v5,
            score  : arg3,
        };
        0x2::transfer::share_object<UserDappScore>(v9);
    }

    public fun new_dapp_score_object_by_admin(arg0: &mut DappScoreManagement, arg1: &DappTargetConfig, arg2: address, arg3: u256, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x1::vector::contains<address>(&arg1.admins, &v0), 1);
        let v1 = 0x2::bcs::to_bytes<address>(&arg2);
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<address>(&arg1.dapp));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<0x1::string::String>(&arg1.target));
        assert!(!0x2::table::contains<vector<u8>, bool>(&arg0.score_object_exist, v1), 2);
        0x2::table::add<vector<u8>, bool>(&mut arg0.score_object_exist, v1, true);
        let v2 = UserDappScore{
            id     : 0x2::object::new(arg4),
            user   : arg2,
            dapp   : arg1.dapp,
            target : arg1.target,
            score  : arg3,
        };
        0x2::transfer::share_object<UserDappScore>(v2);
    }

    public fun remove_admin(arg0: &mut DappScoreManagement, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.admins, &arg1);
        let v2 = 0x2::tx_context::sender(arg2);
        let v3 = is_admin(arg0, &v2) && arg1 != arg0.creator;
        assert!(v3 && v0, 1);
        0x1::vector::swap_remove<address>(&mut arg0.admins, v1);
    }

    public fun remove_dapp_target_admin(arg0: &mut DappTargetConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.admins, &arg1);
        let v2 = 0x2::tx_context::sender(arg2);
        let v3 = 0x1::vector::contains<address>(&arg0.admins, &v2) && 0x1::vector::length<address>(&arg0.admins) > 1;
        assert!(v3 && v0, 1);
        0x1::vector::swap_remove<address>(&mut arg0.admins, v1);
    }

    public fun reset_dapp_score_object_by_admin(arg0: &DappTargetConfig, arg1: &mut UserDappScore, arg2: u256, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x1::vector::contains<address>(&arg0.admins, &v0) && arg0.dapp == arg1.dapp && arg0.target == arg1.target, 1);
        arg1.score = arg2;
    }

    public fun update_dapp_score_object(arg0: &mut UserDappScore, arg1: DappScoreUpadteRequest, arg2: u256, arg3: &mut 0x2::tx_context::TxContext) {
        let DappScoreUpadteRequest {
            id     : v0,
            user   : v1,
            dapp   : v2,
            target : v3,
            proof  : _,
        } = arg1;
        0x2::object::delete(v0);
        assert!(arg0.user == v1 && arg0.dapp == v2 && arg0.target == v3, 1);
        arg0.score = arg0.score + arg2;
    }

    public fun update_dapp_score_object_by_admin(arg0: &DappTargetConfig, arg1: &mut UserDappScore, arg2: u256, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x1::vector::contains<address>(&arg0.admins, &v0) && arg0.dapp == arg1.dapp && arg0.target == arg1.target, 1);
        if (arg3) {
            arg1.score = arg1.score - arg2;
        } else {
            arg1.score = arg1.score + arg2;
        };
    }

    public fun update_dapp_target_description(arg0: &mut DappTargetConfig, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x1::vector::contains<address>(&arg0.admins, &v0), 1);
        arg0.description = 0x1::string::utf8(arg1);
    }

    public fun update_dapp_target_display_name(arg0: &mut DappTargetConfig, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x1::vector::contains<address>(&arg0.admins, &v0), 1);
        arg0.display_name = 0x1::string::utf8(arg1);
    }

    public fun update_dapp_target_image_url(arg0: &mut DappTargetConfig, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x1::vector::contains<address>(&arg0.admins, &v0), 1);
        arg0.image_url = 0x1::string::utf8(arg1);
    }

    // decompiled from Move bytecode v6
}

