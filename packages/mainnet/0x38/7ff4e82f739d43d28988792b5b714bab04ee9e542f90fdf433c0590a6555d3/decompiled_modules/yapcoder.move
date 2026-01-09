module 0x387ff4e82f739d43d28988792b5b714bab04ee9e542f90fdf433c0590a6555d3::yapcoder {
    struct YapCoder has key {
        id: 0x2::object::UID,
        github_user_id: u64,
        dev: address,
        username: 0x1::string::String,
        links: vector<Link>,
        created_at: u64,
        validated_at: 0x1::option::Option<u64>,
    }

    struct Link has store {
        packageID: 0x2::object::ID,
        repoID: 0x1::string::String,
        hash: 0x1::string::String,
    }

    struct YapCoderCreated has copy, drop {
        coder_id: 0x2::object::ID,
        github_user_id: u64,
        dev: address,
        username: 0x1::string::String,
        package_id: 0x2::object::ID,
        repo_full_name: 0x1::string::String,
        first_commit_hash: 0x1::string::String,
        created_at: u64,
    }

    struct LinkAdded has copy, drop {
        coder_id: 0x2::object::ID,
        package_id: 0x2::object::ID,
        repo_id: 0x1::string::String,
        hash: 0x1::string::String,
    }

    public fun add_new_link(arg0: &mut YapCoder, arg1: 0x2::object::ID, arg2: 0x1::string::String, arg3: 0x1::string::String) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Link>(&arg0.links)) {
            if (0x1::vector::borrow<Link>(&arg0.links, v0).repoID == arg2) {
                return
            };
            v0 = v0 + 1;
        };
        let v1 = Link{
            packageID : arg1,
            repoID    : arg2,
            hash      : arg3,
        };
        0x1::vector::push_back<Link>(&mut arg0.links, v1);
        let v2 = LinkAdded{
            coder_id   : 0x2::object::id<YapCoder>(arg0),
            package_id : arg1,
            repo_id    : arg2,
            hash       : arg3,
        };
        0x2::event::emit<LinkAdded>(v2);
    }

    public fun create_yap_coder(arg0: u64, arg1: 0x1::string::String, arg2: 0x2::object::ID, arg3: address, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = YapCoder{
            id             : 0x2::object::new(arg7),
            github_user_id : arg0,
            dev            : arg3,
            username       : arg1,
            links          : 0x1::vector::empty<Link>(),
            created_at     : 0x2::clock::timestamp_ms(arg6),
            validated_at   : 0x1::option::none<u64>(),
        };
        let v1 = Link{
            packageID : arg2,
            repoID    : arg4,
            hash      : arg5,
        };
        0x1::vector::push_back<Link>(&mut v0.links, v1);
        let v2 = YapCoderCreated{
            coder_id          : 0x2::object::uid_to_inner(&v0.id),
            github_user_id    : arg0,
            dev               : arg3,
            username          : arg1,
            package_id        : arg2,
            repo_full_name    : arg4,
            first_commit_hash : arg5,
            created_at        : v0.created_at,
        };
        0x2::event::emit<YapCoderCreated>(v2);
        0x2::transfer::transfer<YapCoder>(v0, arg3);
    }

    // decompiled from Move bytecode v6
}

