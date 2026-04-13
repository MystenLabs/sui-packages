module 0x8585d9584893de6c197fd2eaf759f369cecf3a1eb6a94cc762a0a0674b2f197b::v1 {
    struct SharedObjectRef has copy, drop, store {
        id: 0x2::object::ID,
        ref_mut: bool,
    }

    struct InterfacePackageConfig has copy, drop, store {
        shared_objects: vector<SharedObjectRef>,
    }

    struct AnnounceInterfacePackageEvent<phantom T0> has copy, drop {
        shared_objects: vector<SharedObjectRef>,
    }

    public fun announce_interface_package<T0: key>(arg0: &0x2::object::UID, arg1: &T0, arg2: vector<SharedObjectRef>) {
        assert!(0x2::object::uid_to_inner(arg0) == 0x2::object::id<T0>(arg1), 13906834423451484161);
        let v0 = AnnounceInterfacePackageEvent<T0>{shared_objects: arg2};
        0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::event::emit<AnnounceInterfacePackageEvent<T0>>(v0);
    }

    public fun new_announce_interface_package_event<T0>(arg0: vector<SharedObjectRef>) : AnnounceInterfacePackageEvent<T0> {
        AnnounceInterfacePackageEvent<T0>{shared_objects: arg0}
    }

    public fun new_interface_package_config(arg0: vector<SharedObjectRef>) : InterfacePackageConfig {
        InterfacePackageConfig{shared_objects: arg0}
    }

    public fun shared_object_ref_imm(arg0: 0x2::object::ID) : SharedObjectRef {
        SharedObjectRef{
            id      : arg0,
            ref_mut : false,
        }
    }

    public fun shared_object_ref_mut(arg0: 0x2::object::ID) : SharedObjectRef {
        SharedObjectRef{
            id      : arg0,
            ref_mut : true,
        }
    }

    // decompiled from Move bytecode v6
}

