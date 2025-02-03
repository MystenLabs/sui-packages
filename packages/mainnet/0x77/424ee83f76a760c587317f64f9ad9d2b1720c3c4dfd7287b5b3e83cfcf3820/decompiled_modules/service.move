module 0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::service {
    struct Service has store, key {
        id: 0x2::object::UID,
        features: 0x2::vec_set::VecSet<0x1::string::String>,
        other: 0x2::object_bag::ObjectBag,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : (Service, 0x2::object::ID) {
        let v0 = Service{
            id       : 0x2::object::new(arg0),
            features : 0x2::vec_set::empty<0x1::string::String>(),
            other    : 0x2::object_bag::new(arg0),
        };
        (v0, *0x2::object::uid_as_inner(uid(&v0)))
    }

    public(friend) fun add_feature<T0, T1: store + key>(arg0: &mut Service, arg1: T1) {
        let v0 = 0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::utils::get_key_by_struct<T0>();
        assert!(!has_feature(arg0, v0), 600);
        0x2::vec_set::insert<0x1::string::String>(&mut arg0.features, v0);
        0x2::dynamic_object_field::add<0x1::string::String, T1>(&mut arg0.id, v0, arg1);
    }

    public(friend) fun features(arg0: &Service) : &0x2::vec_set::VecSet<0x1::string::String> {
        &arg0.features
    }

    public(friend) fun get_feature<T0, T1: store + key>(arg0: &Service) : &T1 {
        0x2::dynamic_object_field::borrow<0x1::string::String, T1>(&arg0.id, 0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::utils::get_key_by_struct<T0>())
    }

    public(friend) fun get_feature_mut<T0, T1: store + key>(arg0: &mut Service) : &mut T1 {
        0x2::dynamic_object_field::borrow_mut<0x1::string::String, T1>(&mut arg0.id, 0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::utils::get_key_by_struct<T0>())
    }

    public(friend) fun has_feature(arg0: &Service, arg1: 0x1::string::String) : bool {
        0x2::vec_set::contains<0x1::string::String>(&arg0.features, &arg1)
    }

    public(friend) fun remove_feature<T0, T1: store + key>(arg0: &mut Service) : T1 {
        let v0 = 0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::utils::get_key_by_struct<T0>();
        0x2::vec_set::remove<0x1::string::String>(&mut arg0.features, &v0);
        0x2::dynamic_object_field::remove<0x1::string::String, T1>(&mut arg0.id, v0)
    }

    public(friend) fun uid(arg0: &Service) : &0x2::object::UID {
        &arg0.id
    }

    // decompiled from Move bytecode v6
}

