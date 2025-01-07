module 0x9fd90ae353953fb1215e4bf70e0399042bdd5f4540abb9e61ca464cf17e6c93f::launchpad_whitelist {
    struct Activity has store, key {
        id: 0x2::object::UID,
        root: vector<u8>,
        url: 0x2::url::Url,
    }

    struct ActivityList has store, key {
        id: 0x2::object::UID,
        whitelist: 0x2::vec_map::VecMap<0x2::object::ID, 0x2::object::ID>,
    }

    public entry fun check_whitelist(arg0: &Activity, arg1: vector<vector<u8>>, arg2: &0x2::tx_context::TxContext) : bool {
        0x9fd90ae353953fb1215e4bf70e0399042bdd5f4540abb9e61ca464cf17e6c93f::merkle_proof::verify(arg1, arg0.root, 0x1::hash::sha3_256(0x2::address::to_bytes(0x2::tx_context::sender(arg2))))
    }

    public(friend) fun create_activity(arg0: &mut ActivityList, arg1: 0x2::object::ID, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::url::new_unsafe_from_bytes(arg3);
        let v1 = Activity{
            id   : 0x2::object::new(arg4),
            root : arg2,
            url  : v0,
        };
        0x2::vec_map::insert<0x2::object::ID, 0x2::object::ID>(&mut arg0.whitelist, arg1, 0x2::object::id<Activity>(&v1));
        0x9fd90ae353953fb1215e4bf70e0399042bdd5f4540abb9e61ca464cf17e6c93f::launchpad_event::activity_created_event(0x2::object::id<Activity>(&v1), arg1, arg2, v0);
        0x2::transfer::share_object<Activity>(v1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ActivityList{
            id        : 0x2::object::new(arg0),
            whitelist : 0x2::vec_map::empty<0x2::object::ID, 0x2::object::ID>(),
        };
        0x2::transfer::public_share_object<ActivityList>(v0);
    }

    public(friend) fun modify_activity(arg0: &mut Activity, arg1: vector<u8>, arg2: vector<u8>) {
        arg0.root = arg1;
        arg0.url = 0x2::url::new_unsafe_from_bytes(arg2);
    }

    // decompiled from Move bytecode v6
}

